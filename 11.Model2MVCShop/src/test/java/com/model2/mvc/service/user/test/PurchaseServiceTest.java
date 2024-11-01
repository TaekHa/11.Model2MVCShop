package com.model2.mvc.service.user.test;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;


/*
 *	FileName :  UserServiceTest.java
 * �� JUnit4 (Test Framework) �� Spring Framework ���� Test( Unit Test)
 * �� Spring �� JUnit 4�� ���� ���� Ŭ������ ���� ������ ��� ���� �׽�Ʈ �ڵ带 �ۼ� �� �� �ִ�.
 * �� @RunWith : Meta-data �� ���� wiring(����,DI) �� ��ü ����ü ����
 * �� @ContextConfiguration : Meta-data location ����
 * �� @Test : �׽�Ʈ ���� �ҽ� ����
 */
@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
		"classpath:config/context-aspect.xml",
		"classpath:config/context-mybatis.xml",
		"classpath:config/context-transaction.xml" })
//@ContextConfiguration(locations = { "classpath:config/commonservice.xml" })
public class PurchaseServiceTest {

	//==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	@Transactional
	@Test
	public void testAddPurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		purchase.setPurchaseProd(productService.getProduct(10006));
		purchase.setBuyer(userService.getUser("admin"));
		purchase.setPaymentOption("1");
		purchase.setReceiverName("test");
		purchase.setReceiverPhone("0000000000");
		purchase.setDivyAddr("testAddr");
		purchase.setDivyRequest("testRequest");
		purchase.setTranCode("1");
		purchase.setDivyDate("19000101");
		
		
		purchaseService.addPurchase(purchase);
		
		purchase = purchaseService.getPurchaseByProd(10006);

		//==> console Ȯ��
		System.out.println(purchase);
		
		//==> API Ȯ��
		Assert.assertEquals(10006, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("admin", purchase.getBuyer().getUserId());
		Assert.assertEquals("1", purchase.getPaymentOption());
		Assert.assertEquals("test", purchase.getReceiverName());
		Assert.assertEquals("0000000000", purchase.getReceiverPhone());
		Assert.assertEquals("testAddr", purchase.getDivyAddr());
		Assert.assertEquals("testRequest", purchase.getDivyRequest());
		Assert.assertEquals("1", purchase.getTranCode());
		Assert.assertEquals("19000101", purchase.getDivyDate());
		
	}
	
//	@Test
	public void testGetPurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		//==> �ʿ��ϴٸ�...
//		purchase.setPurchaseProd(productService.getProduct(10000));
//		purchase.setBuyer(userService.getUser("admin"));
//		purchase.setPaymentOption("0");
//		purchase.setReceiverName("test");
//		purchase.setReceiverPhone("0000000000");
//		purchase.setDivyAddr("testAddr");
//		purchase.setDivyRequest("testRequest");
//		purchase.setTranCode("1");
//		purchase.setDivyDate("19000101");
		
		purchase = purchaseService.getPurchase(10027);

		//==> console Ȯ��
		System.out.println(purchase);
		
		//==> API Ȯ��
		Assert.assertEquals(10027, purchase.getTranNo());
		Assert.assertEquals(10006, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("admin", purchase.getBuyer().getUserId());
		Assert.assertEquals("1", purchase.getPaymentOption());
		Assert.assertEquals("test", purchase.getReceiverName());
		Assert.assertEquals("0000000000", purchase.getReceiverPhone());
		Assert.assertEquals("testAddr", purchase.getDivyAddr());
		Assert.assertEquals("testRequest", purchase.getDivyRequest());
		Assert.assertEquals("1", purchase.getTranCode());
		Assert.assertEquals("19000101", purchase.getDivyDate());
	
	}
	
//	@Test
	public void testGetPurchaseByProd() throws Exception {
		
		Purchase purchase = new Purchase();
		//==> �ʿ��ϴٸ�...
//		purchase.setPurchaseProd(productService.getProduct(10000));
//		purchase.setBuyer(userService.getUser("admin"));
//		purchase.setPaymentOption("0");
//		purchase.setReceiverName("test");
//		purchase.setReceiverPhone("0000000000");
//		purchase.setDivyAddr("testAddr");
//		purchase.setDivyRequest("testRequest");
//		purchase.setTranCode("1");
//		purchase.setDivyDate("19000101");
		
		purchase = purchaseService.getPurchaseByProd(10006);

		//==> console Ȯ��
		System.out.println(purchase);
		
		//==> API Ȯ��
		Assert.assertEquals(10027, purchase.getTranNo());
		Assert.assertEquals(10006, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("admin", purchase.getBuyer().getUserId());
		Assert.assertEquals("1", purchase.getPaymentOption());
		Assert.assertEquals("test", purchase.getReceiverName());
		Assert.assertEquals("0000000000", purchase.getReceiverPhone());
		Assert.assertEquals("testAddr", purchase.getDivyAddr());
		Assert.assertEquals("testRequest", purchase.getDivyRequest());
		Assert.assertEquals("1", purchase.getTranCode());
		Assert.assertEquals("19000101", purchase.getDivyDate());
		
	}
	
//	@Transactional
//	@Test
	 public void testUpdatePurchase() throws Exception{
		 
		Purchase purchase = purchaseService.getPurchase(10027);
		Assert.assertNotNull(purchase);
		
		Assert.assertEquals(10027, purchase.getTranNo());
		Assert.assertEquals(10006, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("admin", purchase.getBuyer().getUserId());
		Assert.assertEquals("1", purchase.getPaymentOption());
		Assert.assertEquals("test", purchase.getReceiverName());
		Assert.assertEquals("0000000000", purchase.getReceiverPhone());
		Assert.assertEquals("testAddr", purchase.getDivyAddr());
		Assert.assertEquals("testRequest", purchase.getDivyRequest());
		Assert.assertEquals("1", purchase.getTranCode());
		Assert.assertEquals("19000101", purchase.getDivyDate());

		purchase.setPaymentOption("2");
		purchase.setReceiverName("change");
		purchase.setReceiverPhone("9999999999");
		purchase.setDivyAddr("changeAddr");
		purchase.setDivyRequest("changeRequest");
		purchase.setDivyDate("20000101");
		
		purchaseService.updatePurchase(purchase);
		
		purchase = purchaseService.getPurchase(10027);
		Assert.assertNotNull(purchase);
		
		//==> console Ȯ��
		System.out.println(purchase);
			
		//==> API Ȯ��
		Assert.assertEquals("2", purchase.getPaymentOption());
		Assert.assertEquals("change", purchase.getReceiverName());
		Assert.assertEquals("9999999999", purchase.getReceiverPhone());
		Assert.assertEquals("changeAddr", purchase.getDivyAddr());
		Assert.assertEquals("changeRequest", purchase.getDivyRequest());
		Assert.assertEquals("20000101", purchase.getDivyDate());

	 }
	 
//	 @Transactional
//	 @Test
	 public void testUpdateTranCode() throws Exception{
			Purchase purchase = purchaseService.getPurchase(10027);
			Assert.assertNotNull(purchase);
			
			Assert.assertEquals(10027, purchase.getTranNo());
			Assert.assertEquals(10006, purchase.getPurchaseProd().getProdNo());
			Assert.assertEquals("admin", purchase.getBuyer().getUserId());
			Assert.assertEquals("2", purchase.getPaymentOption());
			Assert.assertEquals("change", purchase.getReceiverName());
			Assert.assertEquals("9999999999", purchase.getReceiverPhone());
			Assert.assertEquals("changeAddr", purchase.getDivyAddr());
			Assert.assertEquals("changeRequest", purchase.getDivyRequest());
			Assert.assertEquals("1", purchase.getTranCode());
			Assert.assertEquals("20000101", purchase.getDivyDate());
			
			//==> console Ȯ��
			System.out.println(purchase);
			
			purchaseService.updateTranCode(purchase, 1);
			
			//==> console Ȯ��
			System.out.println(purchase.getTranCode());
			
			Assert.assertEquals("1", purchase.getTranCode());
	 }
	 
	 //==>  �ּ��� Ǯ�� �����ϸ�....
//	 @Test
	 public void testGetPurchaseList() throws Exception{
		 
	 	Search search = new Search();
	 	String userId = "user04";
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	Map<String,Object> map = purchaseService.getPurchaseList(search, userId);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console Ȯ��
	 	//System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }
	 	 
}