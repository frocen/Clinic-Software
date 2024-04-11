package neighborhooddoc.app.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Prescription {
    private String medicine;
    private String patient;
    private String quantity;
}
