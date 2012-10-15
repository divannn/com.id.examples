package osgi;

import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;

import osgi_service.api.IService;

/**
 * @author idanilov
 *
 */
public class ServiceConsumerActivator
		implements BundleActivator {

	private ServiceReference helloServiceReference;

	public void start(BundleContext context) throws Exception {
		System.out.println("Hello World!!");
		helloServiceReference = context.getServiceReference(IService.class.getName());
		IService helloService = (IService) context.getService(helloServiceReference);
		System.out.println(helloService.sayHello());

	}

	public void stop(BundleContext context) throws Exception {
		System.out.println("Goodbye World!!");
		context.ungetService(helloServiceReference);
	}

}
