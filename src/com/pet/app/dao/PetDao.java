package com.pet.app.dao;

import com.pet.app.entity.Pet;

import java.util.List;
//关键入口：PetDao 调用 BaseDao 并传入 Pet.class
public class PetDao extends BaseDao {

    /**
     * 保存（添加）一只宠物
     * @param pet 宠物对象
     * @return 影响的行数，大于 0 说明成功
     */
    //一、保存/添加一只宠物
    public int savePet(Pet pet) {
        String sql = "INSERT INTO pet_info(user_id, name, type, age, weight) VALUES(?, ?, ?, ?, ?)";
        return update(sql, pet.getUserId(), pet.getName(), pet.getType(), pet.getAge(), pet.getWeight());
    }

    //二、根据宠物ID查询宠物信息
    /**
     * 根据宠物ID查询宠物信息
     * @param id 宠物ID
     * @return 返回 null 说明没有找到该宠物
     */
    public Pet queryPetById(Integer id) {
        String sql = "SELECT id, user_id userId, name, type, age, weight, create_time createTime FROM pet_info WHERE id = ?";
        // 传入 Pet.class 作为类型参数
        return queryForOne(Pet.class, sql, id);
    }

    //三、根据用户ID查询该用户的所有宠物
    /**
     * 根据用户ID查询该用户的所有宠物
     * @param userId 用户ID
     * @return 宠物列表，可能为空
     */
    public List<Pet> queryPetsByUserId(Integer userId) {
        String sql = "SELECT id, user_id userId, name, type, age, weight, create_time createTime FROM pet_info WHERE user_id = ?";
        return queryForList(Pet.class, sql, userId);
    }

    /**
     * 更新宠物信息
     * @param pet 包含新信息的宠物对象
     * @return 影响的行数，大于 0 说明成功
     */
    public int updatePet(Pet pet) {
        String sql = "UPDATE pet_info SET name = ?, type = ?, age = ?, weight = ? WHERE id = ?";
        return update(sql, pet.getName(), pet.getType(), pet.getAge(), pet.getWeight(), pet.getId());
    }

    /**
     * 根据宠物ID删除宠物
     * @param id 宠物ID
     * @return 影响的行数，大于 0 说明成功
     */
    public int deletePetById(Integer id) {
        String sql = "DELETE FROM pet_info WHERE id = ?";
        return update(sql, id);
    }
}
