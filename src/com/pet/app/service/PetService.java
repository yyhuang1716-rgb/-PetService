package com.pet.app.service;

import com.pet.app.dao.PetDao;
import com.pet.app.entity.Pet;

import java.util.List;

public class PetService {

    private PetDao petDao = new PetDao();

    /**
     * 业务：添加宠物
     * @param pet 宠物信息
     * @return true 表示添加成功，false 表示添加失败
     */
    public boolean addPet(Pet pet) {
        int rows = petDao.savePet(pet);
        return rows > 0;
    }

    /**
     * 业务：获取某个用户的所有宠物
     * @param userId 用户ID
     * @return 该用户的宠物列表
     */
    public List<Pet> getPetsByUserId(Integer userId) {
        return petDao.queryPetsByUserId(userId);
    }

    /**
     * 业务：根据宠物ID查询宠物详情
     * @param id 宠物ID
     * @return 返回 null 表示未找到该宠物
     */
    public Pet getPetById(Integer id) {
        return petDao.queryPetById(id);
    }

    /**
     * 业务：更新宠物信息
     * @param pet 包含更新后的宠物对象
     * @return true 表示更新成功，false 表示更新失败
     */
    public boolean updatePetInfo(Pet pet) {
        int rows = petDao.updatePet(pet);
        return rows > 0;
    }

    /**
     * 业务：删除宠物
     * @param id 宠物ID
     * @return true 表示删除成功，false 表示删除失败
     */
    public boolean removePet(Integer id) {
        return deletePet(id);
    }

    /**
     * 业务：删除宠物（Servlet 中使用的名称）
     * @param id 宠物ID
     * @return true 表示删除成功，false 表示删除失败
     */
    public boolean deletePet(Integer id) {
        int rows = petDao.deletePetById(id);
        return rows > 0;
    }

    /**
     * 业务：获取当前用户的所有宠物（Servlet 中使用的名称）
     * @param userId 用户ID
     * @return 该用户的宠物列表
     */
    public List<Pet> getMyPets(Integer userId) {
        return petDao.queryPetsByUserId(userId);
    }
}
