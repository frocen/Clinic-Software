package neighborhooddoc.app.model;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Medicine {
    @TableId(type= IdType.ASSIGN_UUID)
    private String id;
    private String name;
    private String description;
    private int stock;

}