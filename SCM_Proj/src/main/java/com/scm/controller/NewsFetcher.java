package com.scm.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class NewsFetcher {
    private static final String URL = "https://finance.naver.com/news/news_list.naver?mode=LSS2D&section_id=101&section_id2=258";

    public ArrayList<NewsData> fetchNews() throws IOException {
        Document doc = Jsoup.connect(URL).get();
        Elements newsTop = doc.select("dd.articleSummary");
        List<NewsData> newsList = new ArrayList<>();

        for (Element item : newsTop) {
            String text = item.text(); // 뉴스 내용
            newsList.add(new NewsData(text));
        }

        // 뉴스가 5개 미만일 경우 예외 방지
        int endIndex = Math.min(5, newsList.size());
        return new ArrayList<>(newsList.subList(0, endIndex));
    }

    // 뉴스 데이터 클래스
    public static class NewsData {
        private String text;

        public NewsData(String text) {
            this.text = text;
        }

        public void setText(String text) {
            this.text = text;
        }

        public String getText() {
            return text;
        }
    }

    // 가져온 뉴스 데이터를 처리하는 메서드 (예: 대문자 변환)
    public void processFetchedNews(List<NewsData> newsList) {
        for (NewsData news : newsList) {
            String processedText = news.getText().toUpperCase();  // 모든 텍스트 대문자로 변환
            news.setText(processedText);
        }
    }
}
