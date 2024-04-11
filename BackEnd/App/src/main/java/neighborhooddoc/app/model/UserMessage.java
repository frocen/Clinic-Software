package neighborhooddoc.app.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Description
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserMessage {
    private String username;
    private String message;
    private String toUserName;
    private Date createTime;

}
