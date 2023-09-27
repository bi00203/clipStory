package com.example.movie.model.dao;

import com.example.movie.model.dto.BoardDTO;
import com.example.movie.model.dto.CommentDTO;
import lombok.Cleanup;
import lombok.extern.log4j.Log4j2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Log4j2
public class CommentDAO {

    public boolean insertComment(CommentDTO commentDTO) throws Exception {
        /* 게시물 추가 */
        @Cleanup Connection connection = ConnectionUtil.INSTANCE.getConnection();
        String sql = "insert into `comment` (nickName, comment, addDate, memberId, contentNo) values(?, ?, now(), ?, ?)";
        @Cleanup PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, commentDTO.getNickName());
        preparedStatement.setString(2, commentDTO.getComment());
        preparedStatement.setString(3, commentDTO.getMemberId());
        preparedStatement.setInt(4, commentDTO.getContentNo());
        return preparedStatement.executeUpdate() == 1;
    }

    public List<CommentDTO> selectComments(int contentNo) throws SQLException, ClassNotFoundException{
        log.info("selectComments()...");

        List<CommentDTO> commentDTOS = new ArrayList<>();
        String sql = "SELECT * FROM `comment` WHERE contentNo = ?";
        @Cleanup Connection connection = ConnectionUtil.INSTANCE.getConnection();
        @Cleanup PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, contentNo);
        @Cleanup ResultSet resultSet = preparedStatement.executeQuery();

        while(resultSet.next()){
            CommentDTO commentDTO = CommentDTO.builder()
                    .commentNo(resultSet.getInt("commentNo"))
                    .memberId(resultSet.getString("memberId"))
                    .nickName(resultSet.getString("nickName"))
                    .comment(resultSet.getString("comment"))
                    .addDate(resultSet.getString("addDate"))
                    .build();
            commentDTOS.add(commentDTO);
        }
        return commentDTOS;

    }
}
