package com.kh.common;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.oreilly.servlet.multipart.FileRenamePolicy;

/**
 * 1.중복된 파일 덮어쓰기 방지
 * 2.한글/특수문자가 섞인 파일명의 에러방지
 *  -> 사용자가 업로드한 원래 파일명은 db에 보관함.
 *  
 *  곽경국.jpg -> 20181220_163230567_34436.jpg
 *  
 *  originalFileName : 곽경국.jpg
 *  renameFileName : 20181220_163230567_34436.jpg
 */
public class MyFileRenamePolicy implements FileRenamePolicy {

	@Override
	public File rename(File oFile) {
		File rFile = null;
		//yyyyMMdd_HHmmssSSS
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
		int rndNum = (int)(Math.random()*1000);//0~999 난수 발생
		
		//확장자
		String oFileName = oFile.getName(); //파일명 가져오기
		String ext = "";
		int dot = oFileName.lastIndexOf('.');
		if(dot > -1) {
			ext = oFileName.substring(dot);
		}
		
		//새파일명 생성
		String rFileName = sdf.format(new Date())+"_"+rndNum+ext;
		
		//renamed파일 객체 생성
		//부모디렉토리, renamedFileName
		//rFile은 아직 파일이 만들어 진게 아님 데이터 객체 생성일 뿐!
		rFile = new File(oFile.getParent(), rFileName);
		
		System.out.printf("[rFileName=%s]\n", rFile.getName());
		
		try {
			//실제파일생성
			rFile.createNewFile();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		return rFile;
	}

}
