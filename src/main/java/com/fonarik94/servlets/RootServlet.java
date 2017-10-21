package com.fonarik94.servlets;

import com.fonarik94.dao.PostDao;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

@Controller
public class RootServlet {
    private static Logger log = LogManager.getLogger();
    @Autowired
    PostDao postDao;
    @Autowired
    HttpServletRequest request;
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String main(Model model){
        model.addAttribute("requestedPage", "/jsp/posts.jsp");
        model.addAttribute("publishedPosts", postDao.getPublishedPosts());
        log.debug(">> Client IP: " + getClientIp(request));
    return "template";
    }
    @RequestMapping(value = "/about")
    public String about(Model model){
        model.addAttribute("aboutPage", postDao.getPostById(1)); //Post ID 1 is about page
        model.addAttribute("requestedPage", "/jsp/about.jsp");
        return "template";
    }
    @RequestMapping(value = "/post/{id}")
    public String getPost(@PathVariable ("id") int id, Model model){
        model.addAttribute("requestedPost", postDao.getPostById(id));
        model.addAttribute("requestedPage", "/jsp/singlePost.jsp");
        return "template";
    }

    private String getClientIp(HttpServletRequest request){
        String clientIp = request.getHeader("X-FORWARDED-FOR");
        if(clientIp == null){
            clientIp = request.getRemoteAddr();
        }
        return clientIp;
    }
}
