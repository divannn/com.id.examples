package osgi_service.impl;

import osgi_service.api.IService;

/**
 * @author idanilov
 *
 */
public class ServiceImpl
		implements IService {

	@Override
	public String sayHello() {
		System.err.println("Inside ServiceImpl.sayHello()");
		return "Hey";
	}

}
