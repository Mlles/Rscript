library(lda)
library(tmcn)
library(wordcloud)
library(jiebaR)

#读取初始文档
cmt <- scan(file="all.cmt", sep="n", what="", encoding="UTF-8")

#read split word lib
data(cora.vocab)

#new worker used to split word
wker = worker(type="mix")

#split vocab to split word
new_user_word(wker, data(cora.vocab))

#do split
result = segment(cmt, wker)

#load stop word
stop <- scan(file="stop", sep="\n", what="", encoding="UTF-8")

# first time remove stop word
# focus to english abbr usage like i'll
result = result[result%in%stop==FALSE]

# remove length less than 2
result <- subset(result, nchar(result)> 2)

# remove non word and digital
result <- gsub(pattern="[\\W|0-9]+", "", result)

# to lowercase
result <- tolower(result)

# second time to remove stop word
result = result[result%in%stop==FALSE]

# calculate word frequence
word_freq <- table(result)

# prepare graphic
opar <- par(no.readonly = TRUE)
par(bg = 'black')

# paint wordcloud
wordcloud(names(word_freq), word_freq, max.words=150, random.color=TRUE, color=rainbow(n=10))

#output paint
par(opar)

