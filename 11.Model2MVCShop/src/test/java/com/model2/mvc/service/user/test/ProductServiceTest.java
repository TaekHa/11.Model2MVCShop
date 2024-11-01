package com.model2.mvc.service.user.test;

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
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


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
public class ProductServiceTest {

	//==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Transactional
	@Test
	public void testAddProduct() throws Exception {
		
		Product product = new Product();
		product.setProdName("testProduct");
		product.setProdDetail("testProdDetail");
		product.setManuDate("00000000");
		product.setPrice(111122);
		product.setFileName("testtest");
		
		productService.addProduct(product);
		
		product = productService.getProductByProdName(product.getProdName());

		//==> console Ȯ��
		System.out.println(product);
		
		//==> API Ȯ��
		Assert.assertEquals("testProduct", product.getProdName());
		Assert.assertEquals("testProdDetail", product.getProdDetail());
		Assert.assertEquals("00000000", product.getManuDate());
		Assert.assertEquals(111122, product.getPrice());
		Assert.assertEquals("testtest", product.getFileName());
	}

//	@Test
	public void testGetProduct() throws Exception {
		
		Product product = new Product();
		//==> �ʿ��ϴٸ�...
//		product.setProdName("testProduct");
//		product.setProdDetail("testProdDetail");
//		product.setManuDate("00000000");
//		product.setPrice(111122);
//		product.setFileName("testtest");
		
		product = productService.getProduct(productService.getProductByProdName("testProduct").getProdNo());

		//==> console Ȯ��
		System.out.println(product);
		
		//==> API Ȯ��
		Assert.assertEquals(productService.getProductByProdName("testProduct").getProdNo(), product.getProdNo());
		Assert.assertEquals("testProduct", product.getProdName());
		Assert.assertEquals("testProdDetail", product.getProdDetail());
		Assert.assertEquals("00000000", product.getManuDate());
		Assert.assertEquals(111122, product.getPrice());
		Assert.assertEquals("testtest", product.getFileName());
		Assert.assertEquals(null, product.getProTranCode());

		Assert.assertNotNull(productService.getProduct(10000));
		Assert.assertNotNull(productService.getProduct(10005));
	}
	
//	@Transactional
//	@Test
	 public void testUpdateUser() throws Exception{
		 
		Product product = productService.getProduct(productService.getProductByProdName("testProduct").getProdNo());
		Assert.assertNotNull(product);
		
		Assert.assertEquals(productService.getProductByProdName("testProduct").getProdNo(), product.getProdNo());
		Assert.assertEquals("testProduct", product.getProdName());
		Assert.assertEquals("testProdDetail", product.getProdDetail());
		Assert.assertEquals("00000000", product.getManuDate());
		Assert.assertEquals(111122, product.getPrice());
		Assert.assertEquals("testtest", product.getFileName());

		product.setProdName("change");
		product.setProdDetail("changeTestProdDetail");
		product.setPrice(333344);
		product.setFileName("change");
		
		productService.updateProduct(product);
		
		product = productService.getProductByProdName("change");
		Assert.assertNotNull(product);
		
		//==> console Ȯ��
		System.out.println(product);
			
		//==> API Ȯ��
		Assert.assertEquals("change", product.getProdName());
		Assert.assertEquals("changeTestProdDetail", product.getProdDetail());
		Assert.assertEquals(333344, product.getPrice());
		Assert.assertEquals("change", product.getFileName());
	 }
	 
	 //==>  �ּ��� Ǯ�� �����ϸ�....
//	 @Test
	 public void testGetUserListAll() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console Ȯ��
	 	//System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("");
	 	map = productService.getProductList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
	 	//==> console Ȯ��
	 	//System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }
	 
//	 @Test
	 public void testGetUserListByProdNo() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("10000");
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(1, list.size());
	 	
		//==> console Ȯ��
	 	//System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = productService.getProductList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console Ȯ��
	 	//System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }
	 
//	@Test
	 public void testGetUserListByProdName() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("1");
//	 	search.setSearchKeyword("testProduct");
	 	search.setSearchKeyword("change");
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(1, list.size());
	 	
		//==> console Ȯ��
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = productService.getProductList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console Ȯ��
	 	System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }	 
	 
//	 @Test
	 public void testGetUserListByPrice() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("2");
//	 	search.setSearchKeyword("111122");
	 	search.setSearchKeyword("333344");
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(1, list.size());
	 	
		//==> console Ȯ��
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setSearchCondition("2");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = productService.getProductList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console Ȯ��
	 	System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }	 
}