package com.pet.app.service;

import com.pet.app.dao.ServiceItemDao;
import com.pet.app.entity.ServiceItem;

import java.util.List;

public class ServiceItemService {

    private ServiceItemDao serviceItemDao = new ServiceItemDao();

    /**
     * 业务：获取所有服务项目
     * @return 服务项目列表
     */
    public List<ServiceItem> getAllServices() {
        return serviceItemDao.queryAllServices();
    }

    /**
     * 业务：获取某个商家的所有服务项目
     * @param merchantId 商家ID
     * @return 服务项目列表
     */
    public List<ServiceItem> getServicesByMerchantId(Integer merchantId) {
        return serviceItemDao.queryServicesByMerchantId(merchantId);
    }

    /**
     * 业务：根据ID获取服务项目详情
     * @param id 服务ID
     * @return 服务项目对象
     */
    public ServiceItem getServiceById(Integer id) {
        return serviceItemDao.queryServiceById(id);
    }

    /**
     * 业务：根据关键字模糊查询服务项目
     * @param keyword 搜索关键字
     * @return 服务项目列表
     */
    public List<ServiceItem> getServicesByKeyword(String keyword) {
        return serviceItemDao.queryServicesByKeyword(keyword);
    }

    /**
     * 业务：添加服务项目
     * @param serviceItem 服务项目对象
     * @return true 表示添加成功，false 表示添加失败
     */
    public boolean addService(ServiceItem serviceItem) {
        int rows = serviceItemDao.saveService(serviceItem);
        return rows > 0;
    }

    /**
     * 业务：更新服务项目
     * @param serviceItem 服务项目对象
     * @return true 表示更新成功，false 表示更新失败
     */
    public boolean updateService(ServiceItem serviceItem) {
        int rows = serviceItemDao.updateService(serviceItem);
        return rows > 0;
    }

    /**
     * 业务：删除服务项目
     * @param id 服务ID
     * @return true 表示删除成功，false 表示删除失败
     */
    public boolean deleteService(Integer id) {
        int rows = serviceItemDao.deleteServiceById(id);
        return rows > 0;
    }
}
