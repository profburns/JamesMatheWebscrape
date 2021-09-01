
library(rvest);library(selectr);library(xml2)
library(stringr)
library(jsonlite)


url <- 'http://www.jamesmathe.com/by-the-numbers/'
webpage <- read_html(url, 'content-wrapper')

body_text <- webpage %>%
  html_nodes("#content") %>% 
  html_text()
body_text



url <- 'http://www.jamesmathe.com'

webpage <- read_html(url)
links <- webpage %>%
  html_nodes("a") %>% 
  html_attr('href')
links <- unique(links)
links <- str_subset(links, "^(?!.*#comments)")
links <- str_subset(links, "^(?!.*tag)")
links <- str_subset(links, "(http:)")
links <- str_subset(links, "http://www.JamesMathe.com(?!/[0-9]{4}/)")
links <- links[-c(1:11)]

length(links)

blogpost <- vector("list", length(links))
for (i in 1:length(links)) {
  sublink <- read_html(links[i], 'content-wrapper')
  blogpost[[i]] <- sublink %>%
    html_nodes("#content") %>% 
    html_text()
}

library(htmltools)
j<-1
save_html(blogpost[[j]], "blogpost1", background = "white", libdir = "lib")

for(j in 1:length(blogpost)) {
    save_html(blogpost[[j]], paste0("jmblog",j))
                            }
  


