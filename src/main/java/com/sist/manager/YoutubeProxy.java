package com.sist.manager;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Properties;

import com.sist.commons.Commons;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/youtubeProxy")
public class YoutubeProxy extends HttpServlet {
	private static java.util.Map<String, String> cacheMap = new java.util.concurrent.ConcurrentHashMap<>();
    private static java.util.Map<String, Long> timeMap = new java.util.concurrent.ConcurrentHashMap<>();
    private static final long CACHE_DURATION = 3600 * 1000;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String keyword=request.getParameter("keyword");
		if(keyword==null || keyword.trim().isEmpty()) {
			keyword="K리그 하이라이트";
		}
		String maxResults=request.getParameter("max");
		if(maxResults==null || maxResults.trim().isEmpty()) {
			maxResults="4";
		}
		String pageToken=request.getParameter("pageToken");
		String cacheKey=keyword+"_"+maxResults+"_"+(pageToken!=null?pageToken:"first");
		long currentTime=System.currentTimeMillis();
		String cachedData=cacheMap.get(cacheKey);
		Long cacheTime=timeMap.get(cacheKey);
		if(cachedData==null || (currentTime-cacheTime)>CACHE_DURATION) {
			System.out.println("유튜브 API호출");
			cachedData=fetchFromYoutube(keyword,maxResults,pageToken);
			cacheMap.put(cacheKey, cachedData);
			timeMap.put(cacheKey, currentTime);
		}
		response.setContentType("application/json; charset=UTF-8");
	    response.setCharacterEncoding("UTF-8");
	    
	    PrintWriter out = response.getWriter();
	    out.print(cachedData);
	    out.flush();
	}
	private String fetchFromYoutube(String keyword,String maxResult,String pageToken) {
		String youtubeAPI="";
		Properties prop=new Properties();
		StringBuilder result=new StringBuilder();
		try(InputStream is=Thread.currentThread().getContextClassLoader().getResourceAsStream("api.properties")){
			if(is!=null) {
				prop.load(is);
				youtubeAPI=prop.getProperty("youtube.API");
				String searchKeyword=URLEncoder.encode(keyword,"UTF-8");
				String apiUrl="https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults="+maxResult+"&q="+searchKeyword+"&type=video&key="+youtubeAPI;
				if(pageToken!=null&&!pageToken.trim().isEmpty()) {
					apiUrl+="&pageToken="+pageToken;
				}
				URI uri=new URI(apiUrl);
				URL url=uri.toURL();
				HttpURLConnection conn=(HttpURLConnection)url.openConnection();
				conn.setRequestMethod("GET");
				BufferedReader br=new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
				String line;
				while((line=br.readLine())!=null) {
					result.append(line);
				}
				br.close();
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			return "{}";
		}
		return result.toString();
	}
}
