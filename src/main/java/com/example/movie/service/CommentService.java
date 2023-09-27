package com.example.movie.service;

import com.example.movie.model.dao.CommentDAO;
import com.example.movie.model.dto.CommentDTO;
import com.example.movie.model.dto.MemberDTO;
import lombok.extern.log4j.Log4j2;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import java.util.List;

@Log4j2
public enum CommentService {
    INSTANCE;
    private CommentDAO commentDAO;

    CommentService(){
        commentDAO = new CommentDAO();
    }

    public boolean addComment(HttpServletRequest req) throws Exception {
        log.info("addComment()..");

        MemberDTO memberDTO= (MemberDTO) req.getSession().getAttribute("loginInfo");
        CommentDTO commentDTO = CommentDTO.builder()
                .nickName(req.getParameter("nickName"))
                .comment(req.getParameter("comment"))
                .memberId(memberDTO.getMemberId())
                .contentNo(Integer.parseInt(req.getParameter("contentNo")))
                .build();
        return commentDAO.insertComment(commentDTO);
    }

    public List<CommentDTO> getComments(HttpServletRequest req) throws SQLException, ClassNotFoundException {
        log.info("getComments()...");

        int contentNo = Integer.parseInt(req.getParameter("contentNo"));
        List<CommentDTO> commentDTOS = commentDAO.selectComments(contentNo);
        MemberDTO memberDTO= (MemberDTO) req.getSession().getAttribute("loginInfo");

        for(CommentDTO commentDTO : commentDTOS) {
            log.info(commentDTO.getMemberId());
            log.info(memberDTO.getMemberId());

            if(commentDTO.getMemberId().equals(memberDTO.getMemberId())){
                commentDTO.setLogin(true);
            }
        }
        return commentDTOS;
    }

}
