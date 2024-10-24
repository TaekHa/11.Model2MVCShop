package com.model2.mvc.web.product;

import java.io.File;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> 회원관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	//setter Method 구현 않음
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@Value("#{commonProperties['uploadPath']}")
	String uploadPath;
	
	@Autowired
	ServletContext servletContext;
	
	@GetMapping("addProduct")
	public String addUser() throws Exception{
	
		System.out.println("/user/addProduct : GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	
	@PostMapping("addProduct")
	public String addProduct( @ModelAttribute("product") Product product, @RequestParam("file") MultipartFile file) throws Exception {

		System.out.println("/addProduct : POST");
		//Business Logic
		
		String savedName = file.getOriginalFilename();
		String path = servletContext.getRealPath(uploadPath);
		File target = new File(path + savedName);
		
		try{
			file.transferTo(target);
			product.setFileName(savedName);
			productService.addProduct(product);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
		return "forward:/product/addProduct.jsp";
	}
	
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public String getProduct( @RequestParam("prodNo") int prodNo , @RequestParam("menu") String menu, Model model ) throws Exception {
		
		System.out.println("/getProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		model.addAttribute("menu", menu);
		
		if(menu.equals("manage")) {
			return "forward:/product/updateProduct";
		}else {
			return "forward:/product/getProduct.jsp";
		}
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateProductView( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{

		System.out.println("/updateProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct( @ModelAttribute("product") Product product ,@RequestParam("prodNo") int prodNo,@RequestParam("file") MultipartFile file, Model model , HttpSession session) throws Exception{

		System.out.println("/updateProduct : POST");
		//Business Logic
			
		try{
			if(!file.isEmpty()) {
				String savedName = file.getOriginalFilename();			
				String path = servletContext.getRealPath(uploadPath);
				File target = new File(path + savedName);
				file.transferTo(target);
				product.setFileName(savedName);
			}

			productService.updateProduct(product);
			
			model.addAttribute("product", product);
		}catch(Exception e) {
			e.printStackTrace();
		}

		
		return "redirect:/product/getProduct?prodNo="+prodNo+"&menu=ok";
	}
	
	@RequestMapping(value="listProduct")
	public String listProduct( @ModelAttribute("search") Search search , @RequestParam("menu") String menu, Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/listProduct : GET/POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		if(search.getMaxPrice() == 0) {
			search.setMaxPrice(1000000000);
		}
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}
}