package com.example.movie.controller;

import com.example.movie.model.dto.CommentDTO;
import com.example.movie.service.BoardService;
import com.example.movie.service.CommentService;
import lombok.extern.log4j.Log4j2;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

@Log4j2
@WebServlet("/comment/*")
public class CommentController extends HttpServlet {
    CommentService commentService = CommentService.INSTANCE;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String RequestURI = req.getRequestURI();
        String contextPath = req.getContextPath();
        String command = RequestURI.substring(contextPath.length());
        resp.setCharacterEncoding("UTF-8");
        log.info("command : " + command);

        switch (command){
            case "/comment/add":
                try {
                    JSONObject jsonObject = new JSONObject();
                    if (commentService.addComment(req)){
                        jsonObject.put("result", "true");
                    }
                    else{
                        jsonObject.put("result", "false");
                    }
                    resp.getWriter().println(jsonObject.toJSONString());
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
                break;
            case "/comment/addre":
                try {
                    JSONObject jsonObject = new JSONObject();
                    if (commentService.addCommentRe(req)){
                        jsonObject.put("result", "true");
                    }
                    else{
                        jsonObject.put("result", "false");
                    }
                    resp.getWriter().println(jsonObject.toJSONString());
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
                break;
            case "/comment/get":
                try{
                    List<CommentDTO> commentDTOS = commentService.getComments(req);

                    JSONArray jsonArray = new JSONArray();
                    for(CommentDTO commentDTO : commentDTOS){
                        JSONObject jsonObject = new JSONObject();
                        jsonObject.put("commentNo", commentDTO.getCommentNo());
                        jsonObject.put("parentNo", commentDTO.getParentNo());
                        jsonObject.put("nickName",commentDTO.getNickName());
                        jsonObject.put("comment",commentDTO.getComment());
                        jsonObject.put("addDate",commentDTO.getAddDate());
                        jsonObject.put("isLogin",commentDTO.isLogin());
                        jsonArray.add(jsonObject);
                    }
                    resp.getWriter().println(jsonArray.toJSONString());

                } catch (SQLException | ClassNotFoundException e){
                    throw  new RuntimeException(e);
                }
                break;
            case "/comment/remove":
                try {
                    JSONObject jsonObject = new JSONObject();
                    if (commentService.removeComment(req)){
                        jsonObject.put("result", "true");
                    } else {
                        jsonObject.put("result", "false");
                    }
                    resp.getWriter().println(jsonObject.toJSONString());
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
                break;
//            case "/comment/remove/mypage": // 마이페이지 리뷰 삭제
//                try {
//                    JSONArray jsonArray = new JSONArray(req.getReader().lines().collect(Collectors.joining(System.lineSeparator())));
//                    JSONObject jsonObject = new JSONObject();
//                    boolean allDeleted = true;
//
//                    for (int i = 0; i < jsonArray.length(); i++) {
//                        int commentId = jsonArray.getInt(i);
//                        if (!commentService.removeComment(commentId)) {
//                            allDeleted = false;
//                            break;
//                        }
//                    }
//
//                    jsonObject.put("result", allDeleted ? "true" : "false");
//                    resp.getWriter().println(jsonObject.toString());
//                } catch (Exception e) {
//                    throw new RuntimeException(e);
//                }
//                break;

        }
    }

}
