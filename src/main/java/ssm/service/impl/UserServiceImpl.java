
package ssm.service.impl;

import ssm.dao.UserDao;
import ssm.model.User;
import ssm.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service(value="ssm.service.impl")
public class UserServiceImpl implements UserService {
    @Resource
    private UserDao userDao;

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public int delete(int id) {
        return userDao.delete(id);
    }

    @Override
    public int update(User user) {
        return userDao.update(user);
    }

    @Override
    public int add(User user) {
        return userDao.add(user);
    }

    @Override
    public List<User> find(Map<String, Object> map) {
        return userDao.find(map);
    }

    @Override
    public Long getTotal(Map<String, Object> map) {
        return userDao.getTotal(map);
    }
    public User getUserById(int id){
        return userDao.getUserById(id);
    }
}