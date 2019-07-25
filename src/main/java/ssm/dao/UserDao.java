package ssm.dao;

import ssm.model.User;

import java.util.List;
import java.util.Map;

/**
 * 用户DAO接口
 * @author Administrator
 *
 */
public interface UserDao {
    /**
     * 删除用户
     * @param id
     * @return
     */
    public int delete(int id);
    /**
     * 更新用户
     * @param user
     * @return
     */
    public int update(User user);
    /**
     * 添加用户
     * @param user
     * @return
     */
    public int add(User user);
    /**
     * 用户查询
     * @param map
     * @return
     */
    public List<User> find(Map<String,Object> map);
    /**
     * 获取总记录数
     * @param map
     * @return
     */
    public Long getTotal(Map<String,Object> map);
    /**
     * 根据id查询用户
     * @param id
     * @return
     */
    public User getUserById(int id);
}