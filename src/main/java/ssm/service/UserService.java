package ssm.service;

import ssm.model.User;
import java.util.List;
import java.util.Map;

public interface UserService {
    public int delete(int id);
    public int update(User user);
    public int add(User user);
    public List<User> find(Map<String,Object> map);
    public Long getTotal(Map<String,Object> map);
    public User getUserById(int id);
}