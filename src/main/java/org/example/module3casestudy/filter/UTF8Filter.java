package org.example.module3casestudy.filter;

import javax.servlet.*;
import java.io.IOException;

public class UTF8Filter implements Filter {
    public void init(FilterConfig filterConfig) {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        chain.doFilter(request, response);
    }

    public void destroy() {
    }
}
