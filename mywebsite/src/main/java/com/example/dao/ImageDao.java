package com.example.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.example.websiteconstants.WebsiteConstants;



public class ImageDao {
	
	Connection con;
	Statement stmt;
	PreparedStatement preStat;
	ArrayList<String> imglist;
	ArrayList<String> price;
	List<String>[] data;
	
	
	
	
	
	
	public void getConnection()
	{
		try
		
		{  
			Class.forName("com.mysql.jdbc.Driver");  
			
			
			  //final String dbUsername = "saikrish_sai";
			 //final String dbPassword = "QpFmYDu.Ya?X";
			con=DriverManager.getConnection( WebsiteConstants.CONNECTION_STRING,WebsiteConstants.dbUsername,WebsiteConstants.dbPassword);
			
			
			
			
		    //con=DriverManager.getConnection( "jdbc:mysql://localhost:3306/mydatabase","root","root");  
			//here sonoo is database name, root is username and password  
		    
			
			
			
			 stmt=con.createStatement();  
			  
			
			}
		
		catch(Exception e)
		{ 
			//System.out.println(e);
		}  
			
	}
	
	public List[] getList(int search_status,String search_text) 
	{
		imglist = new ArrayList<String>();
		price  = new ArrayList<String>();
		String sql = "select * from imagetable";
		
		if(search_status == 0)
			sql ="select * from imagetable";
		else
			sql ="select * from imagetable where imgname like  "+"'"+search_text.substring(0,1)+"%"+"'" + " limit 3";
		
		//System.out.println("from get list  "+sql);
		data  = new List[2];
		data[0] = imglist;
		data[1] = price;
		getConnection();
		try
		{
		
		ResultSet rs=stmt.executeQuery(sql);  
		while(rs.next())  
		{
		////System.out.println(rs.getString(2));
		imglist.add(rs.getString(2));
		price.add(rs.getString(3));
		}
		con.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return data;
	}
	
	
	
	public void check_and_insert_Item(String prod,String ip_addr,int price,int table)
	{
		String sql ;
		String table_name = "cust_orders";
		//System.out.println("inside check and insert ");
		getConnection();
		try
		{
			if(table == 0)
			{
				table_name = "cust_orders";
			}
			else
			{
				table_name ="pending_orders";
			}
			
			sql = "select * from " + table_name +" where ip_addr = " + "'" + ip_addr + "'" +"  and product = "+"'"+prod+"'" +" and product_purchase_status = 0 and show_in_cart =1";
			//sql = "select * from cust_orders where product = " + "'" + prod + "'" ;
			//System.out.println("check and insert item " +sql);
		
		ResultSet rs=stmt.executeQuery(sql);  
		if(rs.first())  
		{
		   //System.out.println("item exists in cart...check & insert is happening");
			int i =rs.getInt(4);
			
			i=i+1;
			
			
	      sql = "update "+table_name  +" set quantity = "+i +" where id = "+rs.getInt(1);
	      //System.out.println("update sql statement " +sql);
	      
		////System.out.println(rs.getString(2));
		
		}
		else
		{
			//System.out.println("insert item is happening for first time");
			 sql = "insert into "+ table_name+ " (ip_addr,product,quantity,price,cust_id,product_purchase_status,show_in_cart) " +" values("+"'"+ip_addr+"',"+"'"+prod+"',"+1+","+price+",'"+ip_addr+"',"+"0," +"1)";
			  //System.out.println("insert sql statement " +sql);
		 
		}
		stmt.executeUpdate(sql);
		con.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		
	}
	
	public int get_number_of_cart_items(String ip_addr,int table)
	{
		String sql ;
		int total_cart_num =0;
		
		String table_name ="cust_orders";
		
		if(table == 0)
		{
			table_name = "cust_orders";
		}
		else
		{
			table_name ="pending_orders";
		}
		
		
		getConnection();
		try
		{
			sql = "select count(*) from "+table_name +" where ip_addr = " + "'" + ip_addr + "'" +" and show_in_cart = 1";
			//System.out.println("get number of cart items " +sql);
			ResultSet rs=stmt.executeQuery(sql);  
			while(rs.next())  
			{
			////System.out.println(rs.getString(2));
				total_cart_num = rs.getInt(1);
					
			}
			con.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return total_cart_num;
			
	}
	
	public List<List> get_cart_items(String ip_addr,int cust_id,int table)
	{
		String sql ;
		
		String table_name ="cust_orders";
		List<List> cartitems = new ArrayList<List>();
		
		getConnection();
		
		
			
		try
		{
			
			if(table == 0)
			{
				table_name = "cust_orders";
			}
			else
			{
				table_name ="pending_orders";
			}
			
			sql = "select * from  "+table_name+ " where ip_addr = " + "'" + ip_addr + "'" +" and show_in_cart = 1";
			
			//System.out.println("get cart items "+table_name+  "  "+ sql);
			ResultSet rs=stmt.executeQuery(sql);  
			while(rs.next())  
			{
				List<Object> record = new ArrayList<Object>(); //each row is created as list here
			record.add(rs.getString(2));
			record.add(rs.getString(3));
			record.add(rs.getInt(4));
			record.add(rs.getInt(5));
		
			
			
			  cartitems.add(record);
			}
			con.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return cartitems;
		
		
		
			
			
			
	}

	
	
	public void update_cart_item(String prod,int quan,int table)
	{
		String sql ;
		
	    String table_name = "cust_orders";
		
	    if(table == 0)
		{
			table_name = "cust_orders";
		}
		else
		{
			table_name ="pending_orders";
		}
	    
		getConnection();
		try
		{
			 sql = "update " +table_name +" set quantity = "+quan +" where product = "+"'"+prod+"'";
			//System.out.println("update cart items "+sql);
			stmt.executeUpdate(sql);
			
			if(quan == 0)
			{
				  sql ="DELETE FROM " + table_name +" WHERE quantity = 0 ";
				  //System.out.println("update_cart_items deletion will be done "+sql);
			     stmt.executeUpdate(sql); 
			}
				
			  
			con.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
			
	}
	
	public int test()
	{
		//System.out.println("hellow world");
		return 0;
	}
	
	
	// check the user exists or not
	
	public List check_customer_exist(String username,String password)
	{
		int state = 0;
		List<Object> l = new ArrayList<Object>();
		String sql ;
		getConnection();
		try
		{
			sql = "select * from customer where cust_name = " + "'" + username + "'" +" and cust_pass = " + "'" + password + "'" ;
			//System.out.println("check customer exist"+sql);
		
		ResultSet rs=stmt.executeQuery(sql);  
		if(rs.first())  
		{
			state  = 1;
			l.add(rs.getInt(1));
			l.add(state);
			
			//System.out.println("customer details " + l.get(0) + "  " + l.get(1));
			//System.out.println();
		
	      //System.out.println("customer exists in database");
	      
		////System.out.println(rs.getString(2));
		
		}
		else
		{
			state =0 ;
			l.add(999);
			l.add(state);
		}
		con.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		return l;
	}
	
	
	public void insert_customer_data(String user,String pass,String email,String address)
	{
		String sql ;
		getConnection();
		try
		{
			
			 sql = "INSERT INTO customer(cust_name,cust_email,cust_pass,cust_addr)VALUES( " +"'"+user+"',"+"'"+email+"',"+"'"+pass+"',"+"'"+address+"')";
			  //System.out.println("insert customer data " +sql);
		 
		
		stmt.executeUpdate(sql);
		con.close();
		
		}
		
		
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		
	}
	
	/*public void creating_order_from_Cart(String ip_addr,int cust_id)
	{
		String sql =null;
		
		try
		{
			
			//sql = "select * from cust_orders where ip_addr = " + "'" + ip_addr + "'" ;
			
			getConnection();
			
			try
			{
				sql = "select * from cust_orders where ip_addr = " + "'" + ip_addr + "'" ;
				//System.out.println("create order from cart " +sql);
				ResultSet rs=stmt.executeQuery(sql);  
				while(rs.next())  
				{
					
				String ip=rs.getString(2);
				String pro=rs.getString(3);
				int qua= rs.getInt(4);
				int pri =rs.getInt(5);
				//System.out.println("getting orders : " +ip + " " +pro +" " +qua + " " +pri);
				
				sql = "insert into cust_orders (cust_id,product,quantity,price,ip_addr) values (?,?,?,?,?) " ;
				 
				//System.out.println("prepared statement is "+sql);
				preStat = con.prepareStatement(sql);
				preStat.setInt(1, cust_id);
				preStat.setString(2,pro);
				preStat.setInt(3,qua);
				preStat.setInt(4,pri);
				preStat.setString(5,ip_addr);
				
				preStat.executeUpdate();
				
				// code for deleting rows from cust_orders table
				 //sql = "delete from cust_orders where ip_addr = ? and product = ?";
				
				
				//System.out.println(sql);
				preStat = con.prepareStatement(sql);
				preStat.setString(1, ip);
				preStat.setString(2, pro);
				
				preStat.executeUpdate(); 
				
				
				  
				}
				
				
				con.close();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
		
		con.close();
		
		}
		
		
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		
	}*/
	
	public String get_customer_address(int cust_id)
	{
		String sql = "select * from customer where id = " + cust_id  ;
		String cust_address = "pls_add_Address";
		getConnection();
		try
		{
			
			//System.out.println("get customer address "+ sql);
			ResultSet rs=stmt.executeQuery(sql);  
			
			while(rs.next())  
			{
			   //System.out.println("customer addres " +rs.getString(6));
				cust_address = rs.getString(6);
			}
			con.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return cust_address;
		
		
	}
	
	
	public void delete_cart(String ip,int table,int cust_id)
	{
	String sql =null;
	String table_name = "cust_orders";
	
	 if(table == 0)
		{
		 table_name = "cust_orders";
		 sql = "delete from "+ table_name+" where ip_addr = "+   "'" + ip + "'"  ;
		}
		else
		{
			table_name ="pending_orders";
			 sql = "delete from "+ table_name+" where  cust_id = " + cust_id  ;
			
		}
	getConnection();
		try
		{
			
			//sql = "select * from cust_orders where ip_addr = " + "'" + ip_addr + "'" ;
			
			getConnection();
			
			try
			{
				
				
				
				
                stmt.executeUpdate(sql); 
				
				
				System.out.println("items are deleted from cart");
				
				
				
				con.close();
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
		
		con.close();
		
		}
		
		
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
	
	}
	
	private static java.sql.Timestamp getCurrentTimeStamp() {

		java.util.Date today = new java.util.Date();
		return new java.sql.Timestamp(today.getTime());

	}

	
	public void update_product_purchase_status(int cust_id,int status)
	{
		String sql =null;
		getConnection();
			
				
				//sql = "select * from cust_orders where ip_addr = " + "'" + ip_addr + "'" ;
				
				getConnection();
				
				try
				{
					 sql = "update pending_orders " +" set product_purchase_status = "+status+" ,mytimestamp ="+ "'"+ getCurrentTimeStamp()+"'"+" where cust_id ="+cust_id;
						//System.out.println("update show in cart status "+sql);
						stmt.executeUpdate(sql);
	                  
						
					
					//System.out.println( "show_in_cart_status is updated ");
					
					
					
					con.close();
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
					
			
		
		
	
	}
	
	public void update_show_incart_status(String ip_addr,int table,int cust_id,int status)
	{
		String sql =null;
		  String table_name = "cust_orders";
			
		    if(table == 0)
			{
				table_name = "cust_orders";
				 sql = "update "+ table_name +" set show_in_cart = "+status+" ,cust_id ="+cust_id +" where ip_addr = "+"'"+ip_addr+"'";
			}
			else
			{
				table_name ="pending_orders";
				 sql = "update "+ table_name +" set show_in_cart = "+status +" where cust_id = "+cust_id;
			}
		    
		
		getConnection();
			
				
				//sql = "select * from cust_orders where ip_addr = " + "'" + ip_addr + "'" ;
				
				getConnection();
				
				try
				{
					
						//System.out.println("update show in cart status "+sql);
						stmt.executeUpdate(sql);
	                  
						
					
					//System.out.println( "show_in_cart_status is updated ");
					
					
					
					con.close();
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
					
			
	}
	
	public void update_cust_id(String ip_addr,int cust_id)
	{
		String sql =null;
		getConnection();
			
				
				//sql = "select * from cust_orders where ip_addr = " + "'" + ip_addr + "'" ;
				
				getConnection();
				
				try
				{
					 sql = "update cust_orders " +" set cust_id ="+cust_id +" where ip_addr = "+"'"+ip_addr+"'";
						//System.out.println("update show in cart status "+sql);
						stmt.executeUpdate(sql);
	                  
						
					
					//System.out.println( "show_in_cart_status is updated ");
					
					
					
					con.close();
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
					
			
	}
	
	public boolean copy_to_pendingcart_table(int cust_id,String ip_addr)
	{
		String custid= Integer.toString(cust_id);
		String sql ;
		boolean status= false;
		
		getConnection();
		
		try
		{
			 con.setAutoCommit(false);
			sql = "update cust_orders set cust_id = " +custid +" where  ip_addr =" +"'"+ip_addr+"'" ;
			 
			//System.out.println("prepared statement is "+sql);
			int i = stmt.executeUpdate(sql);
			
			 if (i > 0) {
		            System.out.println("success in update " + i);
		            
		            sql = "insert into pending_orders (ip_addr,product,quantity,price,cust_id,product_purchase_status,show_in_cart) "+
		        			"select ip_addr,product,quantity,price,cust_id,product_purchase_status,show_in_cart from cust_orders where cust_id = '"+custid+"'";
		        			
		        			//sql = "select * from cust_orders where product = " + "'" + prod + "'" ;
		        			//System.out.println("*********************************copied to pending cart " +sql);
		        		
		        		   int j = stmt.executeUpdate(sql);  
		        		   if (j > 0) {
		        	            System.out.println("success in insert");
		        	        } else {
		        	            System.out.println("stuck somewhere in insert");
		        	        }
		        		   status = true;
		        		   
		        		   con.commit();
		        		   
		        } else {
		            System.out.println("Network ERROR ...PLEASE TRY AGAIN stuck somewhere in update " + i);
		        }
			
			
	   
		con.close();
		}
		catch(Exception e)
		{
			status  = false;
			try {
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		
		return status;
		
	}

	public void search_box(String search)
	{
        String sql ;
        
        
		
		getConnection();
		try
		{
			
			sql = "select * from imagtable where imgname = "+ "'"+search+"'" ;
			ResultSet rs  = stmt.executeQuery(sql);
			
			while(rs.next())
			{
				
				
			}
			
			
			
	   
		con.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
		
	}
	
}
