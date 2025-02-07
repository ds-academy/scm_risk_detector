package com.scm.model;

public class NewsDTO {
    private int NEWS_ID;
    private String TITLE;
    private String CONTENT;
    private String PUB_DATE;
    private String SOURCE;
    private String NEWS_API;

    
    
    public NewsDTO(String tITLE, String nEWS_API) {
		super();
		TITLE = tITLE;
		NEWS_API = nEWS_API;
	}

    public NewsDTO() {}
    
	// Getters and Setters
    public int getNewsId() {
        return NEWS_ID;
    }

    public void setNewsId(int newsId) {
        this.NEWS_ID = newsId;
    }

    public String getTitle() {
        return TITLE;
    }

    public void setTitle(String title) {
        this.TITLE = title;
    }

    public String getContent() {
        return CONTENT;
    }

    public void setContent(String content) {
        this.CONTENT = content;
    }

    public String getPubDate() {
        return PUB_DATE;
    }

    public void setPubDate(String pubDate) {
        this.PUB_DATE = pubDate;
    }

    public String getSource() {
        return SOURCE;
    }

    public void setSource(String source) {
        this.SOURCE = source;
    }

    public String getNewsApi() {
        return NEWS_API;
    }

    public void setNewsApi(String newsApi) {
        this.NEWS_API = newsApi;
    }
}