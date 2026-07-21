package com.sist.manager;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.fasterxml.jackson.databind.ObjectMapper;

public class NewsManagerRT {
	public static String newsRealTimeData(String fd) {
		String json="";
		String clientId="";
		String clientSecret="";
		Properties prop=new Properties();
		try(InputStream is=Thread.currentThread().getContextClassLoader().getResourceAsStream("api.properties")){
			if(is!=null) {
				prop.load(is);
				clientId=prop.getProperty("naver.ID");
				clientSecret=prop.getProperty("naver.Secret");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		String text=null;
		try {
			text=URLEncoder.encode(fd,"UTF-8");
		}catch(UnsupportedEncodingException ex) {
			throw new RuntimeException("검색어 인코딩 실패",ex);
		}
		String apiURL="https://openapi.naver.com/v1/search/news.json?display=20&query="+text;
		
		Map<String,String> requestHeaders=new HashMap<String, String>();
		requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        String responseBody=get(apiURL,requestHeaders);
        
        try {
        	JSONParser jp=new JSONParser();
	        JSONObject root=(JSONObject)jp.parse(responseBody);
	        if(root!=null) {
	        	if(root.containsKey("items")) {
	        		JSONArray arr=(JSONArray)root.get("items");
	        		if(arr!=null) {
	        			json=arr.toJSONString();
	        		}
	        	}else {
	        		System.err.println("에러:"+responseBody);
	        	}
	        }
        }catch(Exception ex) {
        	ex.printStackTrace();
        }
        return json;
	}
	
	private static String get(String apiUrl,Map<String,String> requestHeaders) {
		HttpURLConnection con=connect(apiUrl);
		try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }


            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 오류 발생
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
	}
	
	private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }


    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);


        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();


            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }


            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
        }
    }
}
