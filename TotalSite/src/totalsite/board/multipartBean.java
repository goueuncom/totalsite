package totalsite.board;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class multipartBean {
	private MultipartRequest multi;
	private String path;
	private int max;
	private String encType;
	
	public multipartBean(){}
	public void setMulti(HttpServletRequest req) {
		try {
			this.multi = new MultipartRequest(req, path, max, encType, new DefaultFileRenamePolicy());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void setPath(String path) {
		this.path = path;
	}

	public void setMax(int max) {
		this.max = max;
	}

	public void setEncType(String encType) {
		this.encType = encType;
	}

	public String getUser(){
		return multi.getParameter("user");
	}
	public String getTitle(){
		return multi.getParameter("title");
	}
	public String getUpFile(){
		String result = "";
		Enumeration	files = multi.getFileNames();
		while(files.hasMoreElements()){
			String name = (String)files.nextElement();
			result += "실제 파일명 : " + multi.getFilesystemName(name) + "<br/>";
			result += "저장 될 파일명 : " + multi.getOriginalFileName(name) + "<br/>";
			result += "파일 타입 : " + multi.getContentType(name) + "<br/><br/>";
		}
		return result;
	}
	public ArrayList getSaveFiles(){
		ArrayList saveFiles = new ArrayList();
		Enumeration files = multi.getFileNames();
		while(files.hasMoreElements()){
			String name = (String)files.nextElement();
			saveFiles.add(multi.getFilesystemName(name));
		}
		return saveFiles;
	}
	public ArrayList getOriginFiles(){
		ArrayList originFiles = new ArrayList();
		Enumeration files = multi.getFileNames();
		while(files.hasMoreElements()){
			String name = (String)files.nextElement();
			originFiles.add(multi.getOriginalFileName(name));
		}
		return originFiles;
	}
}