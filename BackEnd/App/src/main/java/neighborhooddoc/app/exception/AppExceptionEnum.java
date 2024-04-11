package neighborhooddoc.app.exception;

/*
* description: exception enum
* */
public enum AppExceptionEnum {
    NEED_USER_NAME(10001, "empty username"),
    NEED_PASSWORD(10002, "empty password"),
    NAME_EXISTED(10003, "duplicate username"),
    INSERT_FAILED(10004, "insert error,please retry"),
    WRONG_PASSWORD(10005, "wrong password"),
    NEED_LOGIN(10007, "user didn't logged in "),
    UPDATE_FAILED(10008, "update fail"),
    NEED_ADMIN(10009, "no authority"),
    PARA_NOT_NULL(10010, "empty value"),
    CREATE_FAILED(10011, "fail to add"),
    REQUEST_PARAM_ERROR(10012, "request parameter error"),
    DELETE_FAILED(10013, "delete failed");


    Integer code;

    String msg;

    AppExceptionEnum(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
