package com.kh.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class EncodeFilter implements Filter {

	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest request, 
						 ServletResponse response, 
						 FilterChain chain)
			throws IOException, ServletException {
		//1.encoding처리
		request.setCharacterEncoding("utf-8");
		//System.out.println("utf-8 인코딩 처리됨@EncodeFilter");
		
		//(중요)
		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
	}

}
