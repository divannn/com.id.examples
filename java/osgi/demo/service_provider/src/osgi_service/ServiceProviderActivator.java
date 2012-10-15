package osgi_service;

import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceRegistration;

import osgi_service.api.IService;
import osgi_service.impl.ServiceImpl;

/**
 * @author idanilov
 *
 */
public class ServiceProviderActivator
		implements BundleActivator {

	private ServiceRegistration helloServiceRegistration;

	public void start(BundleContext context) throws Exception {
		IService helloService = new ServiceImpl();
		helloServiceRegistration = context.registerService(IService.class.getName(), helloService,
				null);
		System.err.println("Have a service!");
	}

	public void stop(BundleContext context) throws Exception {
		helloServiceRegistration.unregister();
		System.err.println("No service!");
	}

}
