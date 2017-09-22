
//
//  Users.m
//  Bhumesh Purohit
//
//  Created by Bhumesh Purohit on 3/17/15.
//  Copyright (c) 2015 Bhumesh Purohit. All rights reserved.
//

#import "Users.h"
#import "APICall.h"
#import "Constant.h"
#import "AppDelegate.h"
#import "NSData+Base64.h"
#import "Globals.h"

@implementation Users

@synthesize firstName,email,password,lastName,userid,strZipCity,sImage,UserName,passwordLogin,EditFname,EditNumber,apikey,EditLastname, EditAddress,EditCity,EditLocality,EditState,EditPincode,EditMobilnum,EditAddressId,pageno,CouponCode,flag,IsAppliedCoupon,type,searchKey,template_no,CardNum,CVVNum,expMonth,expYear,cardType;

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        self.IsAppliedCoupon=false;
        self.DataForJason=[NSMutableDictionary new];
        self.firstName=[[NSMutableString alloc]init];
        self.password=[[NSMutableString alloc]init];
        self.email=[[NSMutableString alloc]init];
        self.apikey=[[NSMutableString alloc]init];
        self.UserName = [[NSMutableString alloc]init];
        self.passwordLogin =[[NSMutableString alloc]init];
        self.EditFname =[[NSMutableString alloc]init];
        self.EditNumber=[[NSMutableString alloc]init];
        self.mobileNum=[[NSMutableString alloc]init];
        self.CatID=[[NSMutableString alloc]init];
        self.qty=[[NSMutableString alloc]init];
        self.prod_id=[[NSMutableString alloc]init];
        self.EditLastname=[[NSMutableString alloc]init];
        self.EditAddress=[[NSMutableString alloc]init];
        self.EditCity=[[NSMutableString alloc]init];
        self.EditLocality=[[NSMutableString alloc]init];
        self.EditState=[[NSMutableString alloc]init];
        self.EditPincode=[[NSMutableString alloc]init];
        self.EditMobilnum=[[NSMutableString alloc]init];
        self.pageno=[[NSMutableString alloc]init];
        self.CouponCode=[[NSMutableString alloc]init];
        self.userid=0;
        self.flag=[[NSMutableString alloc]init];
        self.type=[[NSMutableString alloc]init];
        self.template_no=[NSMutableString new];
        self.toast=[[NSMutableString alloc]init];
        self.strToken=[[NSMutableString alloc]init];
        self.searchKey=[NSMutableString new];
        self.ArrJasonData=[NSMutableArray new];
        self.CardNum=[[NSMutableString alloc]init];
        self.CVVNum=[[NSMutableString alloc]init];
        self.expMonth=[[NSMutableString alloc]init];
        self.expYear=[[NSMutableString alloc]init];
        self.cardType=[[NSMutableString alloc]init];
        self.Menu_id=[[NSMutableString alloc]init];
        
    }
    
    return self;
}
-(void)Setconfiguration:(user_completion_block)completion
{
  //  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSString *str=[NSString stringWithFormat:@"api_key=%@",api_key1,nil];
  //  [params setObject:api_key1 forKey:@"api_key"];
    [APICall callPostWebService:URL_mobileSettings andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         if(error)
         {
             if(completion)
             {
                 completion(@"OOPS Seems like something is wrong with server",-1);
             }
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else{
             if(completion)
             {
                 if([[ NSString stringWithFormat:@"%@",[user valueForKey:@"status"] ]isEqualToString:@"1"])
                 {
                     NSMutableDictionary *dataConfig=[user valueForKey:@"data"];
                     [[NSUserDefaults standardUserDefaults] setObject:dataConfig forKey:@"Config"];
                     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                     NSString *documentsDirectory = [paths objectAtIndex:0];
                     NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
                     NSFileManager *fileManager = [NSFileManager defaultManager];
                     
                     if (![fileManager fileExistsAtPath: path]) {
                         
                         path = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"Data.plist"] ];
                     }
                     
                     NSMutableDictionary *data;
                     
                     if ([fileManager fileExistsAtPath: path]) {
                         
                         data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
                     }
                     else {
                         // If the file doesn’t exist, create an empty dictionary
                         data = [[NSMutableDictionary alloc] init];
                     }
                     
                     //To insert the data into the plist
                     
                     [data writeToFile:path atomically:YES];
                     [dataConfig writeToFile:path atomically:YES];
                     //To retrieve the data from the plist
                     NSMutableDictionary *savedValue = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
                     NSString *value = [savedValue objectForKey:@"bg_color"];
                     NSLog(@"%@",value);
                     
                     
                     
                      completion(@"Set Config Succeess.",1);
                 }
                 else if([[user valueForKey:@"status"]integerValue]==0)
                 {
                     completion(@"Set Config Failed.",0);
                 }
             }
         }
     }];
}
-(void)registerUser:(user_completion_block)completion  //SignUpVC
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
   
    [params setObject:self.email forKey:@"email"];
    [params setObject:self.firstName forKey:@"fname"];
    [params setObject:self.lastName forKey:@"lname"];
    [params setObject:self.password forKey:@"pass"];
    [params setObject:api_key1 forKey:@"api_key"];
    
 NSString *str=[NSString stringWithFormat:@"api_key=%@&firstName=%@&lastName=%@&password=%@&email=%@",self.apikey,self.firstName,self.lastName,self.password,self.email,nil];
    
    [APICall callPostWebService:URL_SignUP andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         if(error)
         {
             if(completion)
             {
                 completion(@"OOPS Seems like something is wrong with server",-1);
             }
             ////[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else{
             if(completion)
             {
                 if([[ NSString stringWithFormat:@"%@",[user valueForKey:@"status"] ]isEqualToString:@"1"])
                 {
                     // self.userid=[NSString stringWithFormat:@"%@",[[user objectForKey:@"data"]valueForKey:@"userId"] ].integerValue;
                  
                     
                     completion(@"User account registered successfully ",1);
                 }
                 else if([[user valueForKey:@"status"]integerValue]==0)
                 {
                     completion(@"Email id is already registered ",0);
                 }
             }
         }
     }];
}

-(void)loginUser:(user_completion_block)completion   //LoginVC
{
   
    
    NSMutableDictionary *LoginDict = [[NSMutableDictionary alloc] init];
    
    [LoginDict setObject:self.UserName forKey:@"email"];
    [LoginDict setObject:self.passwordLogin forKey:@"pass"];
    [LoginDict setObject:self.apikey forKey:@"api_key"];
 
    NSLog(@"%@",URL_Login);
    
    
    NSString *str=[NSString stringWithFormat:@"email=%@&pass=%@&api_key=%@",self.UserName,self.passwordLogin,self.apikey,nil];
//   [APICall postDataToUrl:URL_Login jsonString:str];
    
    
    
    [APICall callPostWebService:URL_Login andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         self.userid=[[user objectForKey:@"userdetails"]valueForKey:@"userid"] ;
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             ////[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             int status=[[user valueForKey:@"status"] intValue];
             if(status!=0)
             {
             if(completion)
             {
                 AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                 appSharedObj.TotalCartItem=[NSMutableString stringWithFormat:@"%@",[user valueForKey:@"cart_count"]];
                 appSharedObj.localDataDic=[[NSMutableDictionary alloc]
                                            initWithDictionary:[user valueForKey:@"userdetails"]];
                     completion([user valueForKey:@"msg"],1);
                 
             }
             }
             else
             {
                  completion([user valueForKey:@"msg"],0);
                 
             }
             
         }
     }];
}
-(void)allCategory:(user_completion_block)completion
{
    
    NSMutableDictionary *Dict = [[NSMutableDictionary alloc] init];
    [Dict setObject:api_key1 forKey:@"api_key"];
    
    NSString *str=[NSString stringWithFormat:@"api_key=%@",self.apikey,nil];
    
    [APICall callPostWebService:URL_Allcategory andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 int status=[[user valueForKey:@"status"] intValue];
                 if(status!=0)
                 {
                 AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                 NSMutableArray *temp=[[NSMutableArray alloc]
                                       initWithObjects:[user valueForKey:@"data"],nil];
                 appSharedObj.CategoryData=[temp objectAtIndex:0];
                 completion(@"Get Data Successfully",1);
                 }
                 else
                 {
                      completion(@"No Data Found",0);
                 }
             }
         }
     }];
}
-(void)GetProductData:(user_completion_block)completion
{
    NSMutableDictionary *Dict = [[NSMutableDictionary alloc] init];
    [Dict setObject:self.CatID forKey:@"catid"];
    [Dict setObject:self.apikey forKey:@"api_key"];
    [Dict setObject:self.pageno forKey:@"page"];
    [Dict setObject:self.userid forKey:@"userid"];
    [Dict setObject:@"10" forKey:@"limit"];
    NSMutableDictionary *filter=[[NSMutableDictionary alloc]init];
    
    if(self.DataForJason.count>0)
    {
        filter=self.DataForJason;
    }
    
    NSDictionary *dictJsonData = [NSDictionary dictionaryWithObjectsAndKeys:filter,@"filters",nil];
    NSArray *arr=[[NSArray alloc]initWithObjects:dictJsonData, nil];
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    NSString *result;
    if (jsonData && !error)
    {
      jsonString = [[NSString alloc] initWithData:jsonData encoding:NSJSONReadingAllowFragments];
        NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"\n \\"];
      result = [[jsonString componentsSeparatedByCharactersInSet:trim] componentsJoinedByString:@""];
        [Dict setObject:[NSString stringWithFormat:@"%@",result] forKey:@"data"];
        NSLog(@"JSON: %@", jsonString);
    }
      NSString *str=[NSString stringWithFormat:@"catid=%@&api_key=%@&page=%@&userid=%@&limit=10&data=%@",self.CatID,self.apikey,self.pageno,self.userid,result ,nil];
    [APICall callPostWebService:URL_GetProducts andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 int status=[[user valueForKey:@"status"] intValue];
                 if(status!=0)
                 {
              
                 AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                     appSharedObj.TotalPage=[user valueForKey:@"total_page"];
                 NSMutableArray *temp=[[NSMutableArray alloc]
                                       initWithObjects:[user valueForKey:@"data"],nil];
                appSharedObj.FilterData=[[[NSMutableArray alloc]
                                           initWithObjects:[user valueForKey:@"filters"],nil] mutableCopy];
               if([pageno isEqualToString:@"1"])
               {
                   appSharedObj.ProductData=[[temp objectAtIndex:0] mutableCopy];
               }
              else
                {
                    
//                   if(self.IsAppliedCoupon)
//                   {
//                       appSharedObj.ProductData=[[temp objectAtIndex:0] mutableCopy];
//                   }
//                    else
                        [appSharedObj.ProductData addObjectsFromArray:[temp objectAtIndex:0]];
                }
                     NSLog(@"%@",[[appSharedObj.FilterData objectAtIndex:0]valueForKey:@"priceRange"]);
                 
                 
                 completion(@"Get Data Successfully",1);
                 }
                 else
                 {
                        AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                     appSharedObj.FilterData=[[[NSMutableArray alloc]
                                               initWithObjects:[user valueForKey:@"filters"],nil] mutableCopy];
                       completion(@"No Data Found",0);
                 }
             }
         }
     }];
}
-(void)addWishList:(user_completion_block)completion{
    NSMutableDictionary *Dict = [[NSMutableDictionary alloc] init];
    [Dict setObject:self.userid forKey:@"userid"];
    [Dict setObject:self.apikey forKey:@"api_key"];
    [Dict setObject:self.qty forKey:@"qty"];
    [Dict setObject:self.prod_id forKey:@"prodid"];
    [Dict setObject:@"add" forKey:@"flag"];
  
    NSString *str=[NSString stringWithFormat:@"qty=%@&api_key=%@&userid=%@&prodid=%@&flag=add",self.qty,self.apikey,self.userid,self.prod_id,nil];
    
    [APICall callPostWebService:URL_AddWishList andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 
//                 AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//                 NSMutableArray *temp=[[NSMutableArray alloc]
//                                       initWithObjects:[user valueForKey:@"data"],nil];
//                 
//                 appSharedObj.ProductData=[temp objectAtIndex:0];
//                 
//                 
                 completion(@"add Data Successfully",1);
                 
             }
             else
             {
                  completion(@"Data add Failed",0);
             }
         }
     }];
}
-(void)RemoveFromWishList:(user_completion_block)completion
{
    NSMutableDictionary *Dict = [[NSMutableDictionary alloc] init];
    [Dict setObject:self.userid forKey:@"userid"];
    [Dict setObject:self.apikey forKey:@"api_key"];
    [Dict setObject:self.prod_id forKey:@"prodid"];
    [Dict setObject:@"remove" forKey:@"flag"];
      NSString *str=[NSString stringWithFormat:@"api_key=%@&userid=%@&prodid=%@&flag=remove",self.apikey,self.userid,self.prod_id,nil];
    [APICall callPostWebService:URL_AddWishList andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 
                completion(@"Remove From WishList",1);
                 
             }
             else
             {
                   completion(@"Remove From WishList Failed",0);
             }
         }
     }];

}
-(void)clearWishList:(user_completion_block)completion
{
    NSMutableDictionary *Dict = [[NSMutableDictionary alloc] init];
    
    
    [Dict setObject:self.userid forKey:@"userid"];
    [Dict setObject:self.apikey forKey:@"api_key"];
    [Dict setObject:@"clear" forKey:@"flag"];
     NSString *str=[NSString stringWithFormat:@"api_key=%@&userid=%@&flag=clear",self.apikey,self.userid,nil];
    [APICall callPostWebService:URL_AddWishList andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                 
                 [appSharedObj.WishListData removeAllObjects];
                 completion(@"Clear Data",1);
                 
             }
             else
             {
                  completion(@"Clear Data Failled",1);
             }
         }
     }];
    
}
-(void)getWishList:(user_completion_block)completion
{
    // NSString *url_String = [NSString stringWithFormat:@"%@", URL_Login];
    
    NSMutableDictionary *Dict = [[NSMutableDictionary alloc] init];
    
    
    [Dict setObject:self.userid forKey:@"userid"];
    [Dict setObject:self.apikey forKey:@"api_key"];
     NSString *str=[NSString stringWithFormat:@"api_key=%@&userid=%@",self.apikey,self.userid,nil];
    [APICall callPostWebService:URL_GetWishList andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 int status=[[user valueForKey:@"status"] intValue];
                 if(status!=0)
                 {
                 AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                 NSMutableArray *temp=[[NSMutableArray alloc]
                                       initWithObjects:[user valueForKey:@"data"],nil];
                 
                 appSharedObj.WishListData=[[temp objectAtIndex:0] mutableCopy];
                 
                 
                 completion(@"Get Data Successfully",1);
                 }
                 else
                {
                    AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                    [appSharedObj.WishListData removeAllObjects];
                    completion(@"Data Not Found",0);;
                    
                     }
                 
             }
         }
     }];
    
    
}

-(void)AddAdreess:(user_completion_block)completion
{
    // NSString *url_String = [NSString stringWithFormat:@"%@", URL_Login];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    
    [param setObject:self.userid forKey:@"userid"];
    [param setObject:self.apikey forKey:@"api_key"];
     [param setObject:self.EditFname forKey:@"firstname"];
     [param setObject:self.EditLastname forKey:@"lastname"];
     [param setObject:self.EditAddress forKey:@"streetline1"];
     [param setObject:self.EditCity forKey:@"city"];
     [param setObject:self.EditState forKey:@"region"];
     [param setObject:@"IN" forKey:@"region_id"];
      [param setObject:self.EditPincode forKey:@"postcode"];
      [param setObject:self.EditMobilnum forKey:@"mobile"];
     [param setObject:@"IN" forKey:@"country_id"];
    
      NSString *str=[NSString stringWithFormat:@"api_key=%@&userid=%@&firstname=%@&lastname=%@&streetline1=%@&city=%@&region=%@&region_id=IN&postcode=%@&mobile=%@&country_id=IN",self.apikey,self.userid,self.EditFname,self.EditLastname,self.EditAddress,self.EditCity,self.EditState,self.EditPincode,self.EditMobilnum,nil];
    [APICall callPostWebService:URL_addAddress andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                  completion(@"Address add Successfully",1);
                
                 
             }
             else
             {
                  completion(@"Address add Failled",1);
             }
         }
     }];
    
    
}
-(void)EditAdreess:(user_completion_block)completion
{
    // NSString *url_String = [NSString stringWithFormat:@"%@", URL_Login];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    
    [param setObject:self.userid forKey:@"userid"];
    [param setObject:self.apikey forKey:@"api_key"];
    [param setObject:self.EditFname forKey:@"firstname"];
    [param setObject:self.EditLastname forKey:@"lastname"];
    [param setObject:self.EditCity forKey:@"city"];
    [param setObject:self.EditAddress forKey:@"streetline1"];
  //  [param setObject:self.EditCity forKey:@"streetline2"];
    [param setObject:self.EditState forKey:@"region"];
    [param setObject:@"IN" forKey:@"region_id"];
    [param setObject:self.EditPincode forKey:@"postcode"];
    [param setObject:self.EditMobilnum forKey:@"mobile"];
    [param setObject:@"IN" forKey:@"country_id"];
    [param setObject:self.EditAddressId forKey:@"address_id"];
    
     NSString *str=[NSString stringWithFormat:@"api_key=%@&userid=%@&firstname=%@&lastname=%@&streetline1=%@&city=%@&region=%@&region_id=IN&postcode=%@&mobile=%@&country_id=IN&address_id=%@",self.apikey,self.userid,self.EditFname,EditLastname,self.EditAddress,self.EditCity,self.EditState,self.EditPincode,self.EditMobilnum,self.EditAddressId,nil];
    [APICall callPostWebService:URL_EditAddress andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 completion(@"Address add Successfully",1);
                 
                 
             }
             else
             {
                 completion(@"Address add Failled",1);
             }
         }
     }];
    
    
}
-(void)GetAddressData:(user_completion_block)completion
{
    // NSString *url_String = [NSString stringWithFormat:@"%@", URL_Login];
    
    NSMutableDictionary *Dict = [[NSMutableDictionary alloc] init];
    

    [Dict setObject:self.userid forKey:@"userid"];
    [Dict setObject:self.apikey forKey:@"api_key"];
     NSString *str=[NSString stringWithFormat:@"api_key=%@&userid=%@",self.apikey,self.userid,nil];
    [APICall callPostWebService:URL_GetAddress andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 int status=[[user valueForKey:@"status"] intValue];
                 if(status!=0)
                 {
                 AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                 NSMutableArray *temp=[[NSMutableArray alloc]
                                       initWithObjects:[user valueForKey:@"data"],nil];
                 
                 appSharedObj.AddressData=[temp objectAtIndex:0];
                 
                 
                 completion(@"Get Data Successfully",1);
                 }
                 else
                 {
                     completion(@"Data Not Found",0);
                 }
                 
             }
         }
     }];
    
    
}
-(void)GetUserData:(user_completion_block)completion
{
    // NSString *url_String = [NSString stringWithFormat:@"%@", URL_Login];
    
    NSMutableDictionary *Dict = [[NSMutableDictionary alloc] init];
    
    
    [Dict setObject:self.userid forKey:@"userid"];
    [Dict setObject:self.apikey forKey:@"api_key"];
      NSString *str=[NSString stringWithFormat:@"api_key=%@&userid=%@",self.apikey,self.userid,nil];
    [APICall callPostWebService:URL_GetUserInfo andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 int status=[[user valueForKey:@"status"] intValue];
                 if(status!=0)
                 {
                     AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                     NSMutableArray *temp=[[NSMutableArray alloc]
                                           initWithObjects:[user valueForKey:@"data"],nil];
                     
                     appSharedObj.localDataDic=[temp objectAtIndex:0];
                     
                     
                     completion(@"Get Data Successfully",1);
                 }
                 else
                 {
                     completion(@"Data Not Found",0);
                 }
                 
             }
         }
     }];
    
    
}
-(void)DeleteAddressData:(user_completion_block)completion
{
    // NSString *url_String = [NSString stringWithFormat:@"%@", URL_Login];
    
    NSMutableDictionary *Dict = [[NSMutableDictionary alloc] init];
    
    
    [Dict setObject:self.userid forKey:@"userid"];
    [Dict setObject:self.apikey forKey:@"api_key"];
    [Dict setObject:self.EditAddressId forKey:@"addressid"];
     NSString *str=[NSString stringWithFormat:@"api_key=%@&userid=%@&addressid=%@",self.apikey,self.userid,self.EditAddressId ,nil];
    [APICall callPostWebService:URL_DeleteAddress andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 completion(@"Delete Data Successfully",1);
                 
             }
             else
             {
                 completion(@"Delete Data Failled",1);
             }
         }
     }];
    
    
}
-(void)ForgotPassword:(user_completion_block)completion
{
    // NSString *url_String = [NSString stringWithFormat:@"%@", URL_Login];
    
    NSMutableDictionary *Dict = [[NSMutableDictionary alloc] init];
    
    
    [Dict setObject:self.email forKey:@"email"];
    [Dict setObject:self.apikey forKey:@"api_key"];
      NSString *str=[NSString stringWithFormat:@"api_key=%@&email=%@",self.apikey,self.email,nil];
    [APICall callPostWebService:URL_ForgotPassword andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 completion([user objectForKey:@"msg"],1);
                 
             }
             else
             {
                 completion([user objectForKey:@"msg"],0);
             }
         }
     }];
    
    
}
-(void)AddToCart:(user_completion_block)completion
{
    // NSString *url_String = [NSString stringWithFormat:@"%@", URL_Login];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    
    [param setObject:self.userid forKey:@"userid"];
    [param setObject:self.apikey forKey:@"api_key"];
    [param setObject:@"add" forKey:@"flag"];
    [param setObject:self.prod_id forKey:@"prodid"];
    [param setObject:self.qty forKey:@"qty"];
    //  [param setObject:self.EditCity forKey:@"streetline2"];
    [param setObject:self.EditPincode forKey:@"zipcode"];
    NSString *str;
    if(self.ArrJasonData.count>0)
    {
//        NSDictionary *dictJsonData = [NSDictionary dictionaryWithObjectsAndKeys:self.ArrJasonData,@"options",nil];
//    
//       NSArray *arr=[[NSArray alloc]initWithObjects:dictJsonData, nil];
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.ArrJasonData options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
        
    if (jsonData && !error)
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSJSONReadingAllowFragments];
     //   NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"\n \\"];
     //   NSString *result = [[jsonString componentsSeparatedByCharactersInSet:trim] componentsJoinedByString:@""];
        [param setObject:[NSString stringWithFormat:@"%@",jsonString] forKey:@"options"];
        NSLog(@"JSON: %@", jsonString);
    }
        [param setObject:self.userid forKey:@"userid"];
        [param setObject:self.apikey forKey:@"api_key"];
        [param setObject:@"add" forKey:@"flag"];
        [param setObject:self.prod_id forKey:@"prodid"];
        [param setObject:self.qty forKey:@"qty"];
        //  [param setObject:self.EditCity forKey:@"streetline2"];
        [param setObject:self.EditPincode forKey:@"zipcode"];
        
       str=[NSString stringWithFormat:@"api_key=%@&userid=%@&flag=add&prodid=%@&qty=%@&zipcode=%@&options=%@",self.apikey,self.userid,self.prod_id ,self.qty,self.EditPincode ,jsonString ,nil];
    }
     str=[NSString stringWithFormat:@"api_key=%@&userid=%@&flag=add&prodid=%@&qty=%@&zipcode=%@",self.apikey,self.userid,self.prod_id ,self.qty,self.EditPincode ,nil];
    [APICall callPostWebService:URL_AddCart andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 int status=[[user valueForKey:@"status"] intValue];
                 if(status!=0)
                 {
                     AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                     NSMutableArray *temp=[[NSMutableArray alloc]
                                           initWithObjects:[[user valueForKey:@"cartitems"] mutableCopy],nil];
                     
                     appSharedObj.CartData=[[temp objectAtIndex:0] mutableCopy];
                     appSharedObj.TotalCartItem=[NSMutableString stringWithFormat:@"%lu",(unsigned long)appSharedObj.CartData.count];
                     NSMutableArray *temp1=[[NSMutableArray alloc]
                                            initWithObjects:[[user valueForKey:@"total"] mutableCopy],nil];
                     appSharedObj.DiscountData=[[temp1 objectAtIndex:0] mutableCopy];
                     
                     completion(@"Item add Successfully",1);
                 }
                 else
                 {
                     completion(@"Item Not added.",0);
                 }
                 
                 
             }
         }
     }];
    
    
}
-(void)DisplayCart:(user_completion_block)completion
{
    // NSString *url_String = [NSString stringWithFormat:@"%@", URL_Login];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [param setObject:self.userid forKey:@"userid"];
    NSString *str=[NSString stringWithFormat:@"userid=%@",self.userid,nil];
    [APICall callPostWebService:URL_DisplayCart andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
            int status=[[user valueForKey:@"status"] intValue];
                 if(status!=0)
                 {
                     
                     NSMutableArray *temp=[[NSMutableArray alloc]
                                           initWithObjects:[[user valueForKey:@"cartitems"] mutableCopy],nil];
                     
                     appSharedObj.CartData=[[temp objectAtIndex:0] mutableCopy];
                     self.CouponCode=[NSMutableString stringWithFormat:@"%@",[user valueForKey:@"applied_coupon"]];
                     NSMutableArray *temp1=[[NSMutableArray alloc]
                                           initWithObjects:[[user valueForKey:@"total"] mutableCopy],nil];
                     appSharedObj.DiscountData=[[temp1 objectAtIndex:0] mutableCopy];
                     completion(@"Get Data Successfully",1);
                 }
                 else
                 {
                     
                     completion(@"Data Not Found",0);
                 }
                 
                 
                 
                
                 
             }
         }
     }];
    
    
}
-(void)DeleteItemCart:(user_completion_block)completion
{
    // NSString *url_String = [NSString stringWithFormat:@"%@", URL_Login];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
     AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [param setObject:self.userid forKey:@"userid"];
    [param setObject:self.apikey forKey:@"api_key"];
    [param setObject:self.prod_id forKey:@"prodid"];
    [param setObject:@"remove"forKey:@"flag"];
    
    NSString *str=[NSString stringWithFormat:@"userid=%@&api_key=%@&prodid=%@&flag=remove",self.userid,self.apikey,self.prod_id ,nil];
    [APICall callPostWebService:URL_AddCart andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 int status=[[user valueForKey:@"status"] intValue];
                 if(status!=0)
                 {
                  
                     NSMutableArray *temp=[[NSMutableArray alloc]
                                           initWithObjects:[[user valueForKey:@"cartitems"] mutableCopy],nil];
                     
                     appSharedObj.CartData=[[temp objectAtIndex:0] mutableCopy];
                     appSharedObj.TotalCartItem=[[NSMutableString stringWithFormat:@"%lu",(unsigned long)appSharedObj.CartData.count]mutableCopy];
                     NSMutableArray *temp1=[[NSMutableArray alloc]
                                            initWithObjects:[[user valueForKey:@"total"] mutableCopy],nil];
                     appSharedObj.DiscountData=[[temp1 objectAtIndex:0] mutableCopy];
                     
                     completion([user valueForKey:@"msg"],1);
                 }
                 else
                 {
                     [appSharedObj.CartData removeAllObjects];
                     completion(@"Data Not Found",0);
                 }
                 
                 
                 
                 
                 
             }
         }
     }];
    
    
}
-(void)UpdateCart:(user_completion_block)completion
{
    // NSString *url_String = [NSString stringWithFormat:@"%@", URL_Login];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    
    [param setObject:self.userid forKey:@"userid"];
    [param setObject:self.apikey forKey:@"api_key"];
    [param setObject:self.qty forKey:@"qty"];
    [param setObject:self.prod_id forKey:@"prodid"];
    [param setObject:@"update"forKey:@"flag"];
    
      NSString *str=[NSString stringWithFormat:@"userid=%@&api_key=%@&qty=%@&prodid=%@&flag=update",self.userid,self.apikey,self.qty,self.prod_id ,nil];
    [APICall callPostWebService:URL_AddCart andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 int status=[[user valueForKey:@"status"] intValue];
                 if(status!=0)
                 {
                     AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                     NSMutableArray *temp=[[NSMutableArray alloc]
                                           initWithObjects:[[user valueForKey:@"cartitems"] mutableCopy],nil];
                     
                     appSharedObj.CartData=[[temp objectAtIndex:0] mutableCopy];
                     NSMutableArray *temp1=[[NSMutableArray alloc]
                                            initWithObjects:[[user valueForKey:@"total"] mutableCopy],nil];
                     appSharedObj.DiscountData=[[temp1 objectAtIndex:0] mutableCopy];
                     
                     
                     completion(@"Get Data Successfully",1);
                 }
                 else
                 {
                     completion(@"Data Not Found",0);
                 }
             }
         }
     }];
    
    
}
-(void)SaveAccountData:(user_completion_block)completion
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:self.email forKey:@"email"];
    [params setObject:self.firstName forKey:@"fname"];
    [params setObject:self.lastName forKey:@"lname"];
    [params setObject:api_key1 forKey:@"api_key"];
    [params setObject:self.userid forKey:@"userid"];
    
     NSString *str=[NSString stringWithFormat:@"userid=%@&fname=%@&lname=%@&api_key=%@&email=%@",self.userid,self.firstName,self.lastName,api_key1,self.email ,nil];
    [APICall callPostWebService:URL_UpdateUserInfo andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"OOPS Seems like something is wrong with server",-1);
             }
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else{
             if(completion)
             {
                 if([[ NSString stringWithFormat:@"%@",[user valueForKey:@"status"] ]isEqualToString:@"1"])
                 {
                     // self.userid=[NSString stringWithFormat:@"%@",[[user objectForKey:@"data"]valueForKey:@"userId"] ].integerValue;
                     
                     
                     completion(@"User account updated successfully ",1);
                 }
                 else if([[user valueForKey:@"status"]integerValue]==0)
                 {
                     completion(@"User account Not updated ",0);
                 }
             }
         }
     }];
}
-(void)ApplyCoupon:(user_completion_block)completion
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:self.CouponCode forKey:@"coupon_code"];
    [params setObject:self.flag forKey:@"flag"];
    [params setObject:api_key1 forKey:@"api_key"];
    [params setObject:self.userid forKey:@"userid"];
  
    NSString *str=[NSString stringWithFormat:@"userid=%@&coupon_code=%@&api_key=%@&flag=%@",self.userid,self.CouponCode,api_key1,self.flag ,nil];

    [APICall callPostWebService:URL_ApplyCoupon andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"OOPS Seems like something is wrong with server",-1);
             }
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else{
             if(completion)
             {
                 if([[ NSString stringWithFormat:@"%@",[user valueForKey:@"status"] ]isEqualToString:@"1"])
                 {
                     // self.userid=[NSString stringWithFormat:@"%@",[[user objectForKey:@"data"]valueForKey:@"userId"] ].integerValue;
                     AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                  
                     NSMutableArray *temp=[[NSMutableArray alloc]
                                           initWithObjects:[[user valueForKey:@"total"] mutableCopy],nil];
                     appSharedObj.DiscountData  =[temp objectAtIndex:0];
                     
                     completion([user valueForKey:@"msg"],1);
                 }
                 else if([[user valueForKey:@"status"]integerValue]==0)
                 {
                     completion([user valueForKey:@"msg"],0);
                 }
             }
         }
     }];
}
-(void)GetAdvanceProduct:(user_completion_block)completion
{
    // NSString *url_String = [NSString stringWithFormat:@"%@", URL_Login];
    
    NSMutableDictionary *Dict = [[NSMutableDictionary alloc] init];
    
    
    [Dict setObject:api_key1 forKey:@"api_key"];
    [Dict setObject:self.type forKey:@"type"];
    
     NSString *str=[NSString stringWithFormat:@"api_key=%@&type=%@",api_key1,self.type,nil];
    [APICall callPostWebService:URL_AdvanceProduct andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 int status=[[user valueForKey:@"status"] intValue];
                 if(status!=0)
                 {
                     AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                     appSharedObj.TotalPage=[user valueForKey:@"total_page"];
                     NSMutableArray *temp=[[NSMutableArray alloc]
                                           initWithObjects:[user valueForKey:@"data"],nil];
                     
                     appSharedObj.AdvanceProductData=[[temp objectAtIndex:0] mutableCopy];
                     
                     
                     completion(@"Get Data Successfully",1);
                 }
                 else
                 {
                     completion(@"No Data Found",0);
                 }
                 
                 
             }
         }
     }];
    
    
}
-(void)GetAdvanceProductForPagination:(user_completion_block)completion
{
    // NSString *url_String = [NSString stringWithFormat:@"%@", URL_Login];
    
    NSMutableDictionary *Dict = [[NSMutableDictionary alloc] init];
    
    
    [Dict setObject:api_key1 forKey:@"api_key"];
    [Dict setObject:self.type forKey:@"type"];
    
     NSString *str=[NSString stringWithFormat:@"api_key=%@&type=%@",api_key1,self.type,nil];
    [APICall callPostWebService:URL_AdvanceProduct andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 int status=[[user valueForKey:@"status"] intValue];
                 if(status!=0)
                 {
                     AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                     appSharedObj.TotalPage=[user valueForKey:@"total_page"];
                     NSMutableArray *temp=[[NSMutableArray alloc]
                                           initWithObjects:[user valueForKey:@"data"],nil] ;
                      [appSharedObj.AdvanceProductData addObjectsFromArray:[[temp objectAtIndex:0]mutableCopy]];
                     completion(@"Get Data Successfully",1);
                 }
                 else
                 {
                     completion(@"No Data Found",0);
                 }
                 
                 
             }
         }
     }];
    
    
}
-(void)SearchData:(user_completion_block)completion
{
    // NSString *url_String = [NSString stringWithFormat:@"%@", URL_Login];
    
    NSMutableDictionary *Dict = [[NSMutableDictionary alloc] init];
    
    
    [Dict setObject:self.userid forKey:@"userid"];
    [Dict setObject:self.apikey forKey:@"api_key"];
    [Dict setObject:self.searchKey forKey:@"search_key"];
    
     NSString *str=[NSString stringWithFormat:@"api_key=%@&userid=%@&search_key=%@",api_key1,self.userid,self.searchKey,nil];
    [APICall callPostWebService:URL_SearchProduct andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 int status=[[user valueForKey:@"status"] intValue];
                 if(status!=0)
                 {
                     AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                     NSMutableArray *temp=[[NSMutableArray alloc]
                                           initWithObjects:[user valueForKey:@"data"],nil];
                     
                     appSharedObj.ProductData=[[temp objectAtIndex:0] mutableCopy];
                     
                     
                     completion(@"Get Data Successfully",1);
                 }
                 else
                 {
                     completion(@"Data Not Found",0);
                 }
                 
             }
         }
     }];
    
    
}
-(void)GetOrderHistory:(user_completion_block)completion
{
    // NSString *url_String = [NSString stringWithFormat:@"%@", URL_Login];
    
    NSMutableDictionary *Dict = [[NSMutableDictionary alloc] init];
    
    
    [Dict setObject:self.userid forKey:@"userid"];
    [Dict setObject:self.apikey forKey:@"api_key"];
   
       NSString *str=[NSString stringWithFormat:@"api_key=%@&userid=%@",api_key1,self.userid,nil];
    
    [APICall callPostWebService:URL_OrderHistory andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 int status=[[user valueForKey:@"status"] intValue];
                 if(status!=0)
                 {
                     AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                     NSMutableArray *temp=[[NSMutableArray alloc]
                                           initWithObjects:[user valueForKey:@"data"],nil];
                     
                     appSharedObj.OrderHistoryData=[[temp objectAtIndex:0] mutableCopy];
                     
                     
                     completion(@"Get Data Successfully",1);
                 }
                 else
                 {
                     completion([user valueForKey:@"msg"],0);
                 }
                 
             }
         }
     }];
    
    
}
-(void)checkoutPlaceOrder:(user_completion_block)completion
{
    // NSString *url_String = [NSString stringWithFormat:@"%@", URL_Login];
    
 /*   NSMutableDictionary *Dict = [[NSMutableDictionary alloc] init];
    
    
    [Dict setObject:self.userid forKey:@"userid"];
    [Dict setObject:self.apikey forKey:@"api_key"];
    [Dict setObject:@"131" forKey:@"addressid"];*/
    
     NSString *str=[NSString stringWithFormat:@"api_key=%@&userid=%@&addressid=131&ccno=%@&ccexpmonth=%@&ccexpyear=%@&cctype=%@&cc_cvv=%@",api_key1,self.userid,self.CardNum,self.expMonth,self.expYear,self.cardType,self.CVVNum,nil];
    [APICall callPostWebService:URL_checkoutPlaceOrder andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 int status=[[user valueForKey:@"status"] intValue];
                 if(status!=0)
                 {
                     completion([user valueForKey:@"msg"],1);
                 }
                 else
                 {
                     completion([user valueForKey:@"msg"],0);
                 }
                 
             }
         }
     }];
    
    
}
-(void)GetProductDetails:(user_completion_block)completion
{
    NSMutableDictionary *Dict = [[NSMutableDictionary alloc] init];
    [Dict setObject:api_key1 forKey:@"api_key"];
    [Dict setObject:self.userid forKey:@"userid"];
    [Dict setObject:self.prod_id forKey:@"prod_id"];
    NSString *str=[NSString stringWithFormat:@"api_key=%@&userid=%@&prod_id=%@",self.apikey,self.userid,self.prod_id,nil];
    [APICall callPostWebService:URL_ProductDetails andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo]   objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 int status=[[user valueForKey:@"status"] intValue];
                 if(status!=0)
                 {
                     AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                  
                     NSMutableArray *temp=[[NSMutableArray alloc]
                                           initWithObjects:[user valueForKey:@"data"],nil];
                     appSharedObj.AttributeData=[[[temp objectAtIndex:0] valueForKey:@"attributes"] mutableCopy];
                    appSharedObj.ProductDetailsData=[[temp objectAtIndex:0]  mutableCopy];                     
                     
                     completion(@"Get Data Successfully",1);
                 }
                 else
                 {
                     completion(@"No Data Found",0);
                 }
                 
                 
             }
         }
     }];
    
    
}
-(void)ChangePassword:(user_completion_block)completion
{
    // NSString *url_String = [NSString stringWithFormat:@"%@", URL_Login];
    
    NSMutableDictionary *PasswordDict = [[NSMutableDictionary alloc] init];
    [PasswordDict setObject:self.password forKey:@"password"];
    [PasswordDict setObject:self.userid forKey:@"userid"];
    [PasswordDict setObject:api_key1 forKey:@"api_key"];
     NSString *str=[NSString stringWithFormat:@"api_key=%@&userid=%@&password=%@",self.apikey,self.userid,self.password,nil];
    
    [APICall callPostWebService:URL_ChangePassword andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 
                 
                 completion([user objectForKey:@"msg"],1);
                 
             }
             else
             {
                 completion([user objectForKey:@"msg"],0);
             }
         }
     }];
}
-(void)GetSettingPages:(user_completion_block)completion
{
     NSString *str=[NSString stringWithFormat:@"api_key=%@&menu_id=%@",api_key1,self.Menu_id,nil];
    [APICall callPostWebService:URL_mobileCmsPages andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 
                 
                 
                 int status=[[user valueForKey:@"status"] intValue];
                 if(status!=0)
                 {
                     AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                     
                     NSMutableArray *temp=[[NSMutableArray alloc]
                                           initWithObjects:[user valueForKey:@"data"],nil];
                     appSharedObj.ArrMobileCMS=[[temp objectAtIndex:0] mutableCopy];                    
                     
                     
                     completion([user objectForKey:@"msg"],1);
                 }
                 else
                 {
                     completion(@"No Settings Set.",0);
                 }
                 
             }
             else
             {
                 completion([user objectForKey:@"msg"],0);
             }
         }
     }];
}
-(void)GetMobileBanner:(user_completion_block)completion
{
   
    NSString *str=[NSString stringWithFormat:@"api_key=%@&template=%@",api_key1,self.template_no,nil];
    [APICall callPostWebService:URL_mobileBanners andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 if([[ NSString stringWithFormat:@"%@",[user valueForKey:@"status"] ]isEqualToString:@"1"])
                 {
                     AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                     
                     NSMutableArray *temp=[[NSMutableArray alloc]
                                           initWithObjects:[user valueForKey:@"data"],nil];
                     appSharedObj.ArrImageBanner=[[temp objectAtIndex:0] mutableCopy];
                     temp=[[NSMutableArray alloc]
                                           initWithObjects:[user valueForKey:@"categories"],nil];
                      appSharedObj.ArrCategoryBanner=[[temp objectAtIndex:0] mutableCopy];
                 }
                 else if([[user valueForKey:@"status"]integerValue]==0)
                 {
                     completion([user valueForKey:@"msg"],0);
                 }
                
                 
                 
                 
                 completion([user objectForKey:@"msg"],1);
             }
             else
             {
                 completion([user objectForKey:@"msg"],0);
             }
         }
     }];
}
-(void)GetNotificationHistory:(user_completion_block)completion
{
    NSString *str=[NSString stringWithFormat:@"api_key=%@",api_key1,nil];
    [APICall callPostWebService:URL_NotiFication andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 
                 
                 
                 int status=[[user valueForKey:@"status"] intValue];
                 if(status!=0)
                 {
                     AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                     
                     NSMutableArray *temp=[[NSMutableArray alloc]
                                           initWithObjects:[user valueForKey:@"data"],nil];
                     appSharedObj.ArrNotifications=[[temp objectAtIndex:0] mutableCopy];
                     
                     completion([user objectForKey:@"msg"],1);
                 }
                 else
                 {
                     completion(@"No Settings Set.",0);
                 }
                 
             }
             else
             {
                 completion([user objectForKey:@"msg"],0);
             }
         }
     }];
}
-(void)GetMenuData:(user_completion_block)completion
{
    
    NSString *str=[NSString stringWithFormat:@"api_key=%@",api_key1,nil];
    [APICall callPostWebService:URL_mobileMenu andDictionary:str completion:^(NSDictionary* user, NSError*error, long code)
     {
         
         if(error)
         {
             if(completion)
             {
                 completion(@"There was some error, please try again later",-1);
             }
             //[[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
         }
         else
         {
             if(completion)
             {
                 if([[ NSString stringWithFormat:@"%@",[user valueForKey:@"status"] ]isEqualToString:@"1"])
                 {
                     AppDelegate *appSharedObj = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                     
                     NSMutableArray *temp=[[NSMutableArray alloc]
                                           initWithObjects:[user valueForKey:@"data"],nil];
                     appSharedObj.ArrMenuItems=[[temp objectAtIndex:0] mutableCopy];
                 }
                 else if([[user valueForKey:@"status"]integerValue]==0)
                 {
                     completion([user valueForKey:@"msg"],0);
                 }
                 completion([user objectForKey:@"msg"],1);
             }
             else
             {
                 completion([user objectForKey:@"msg"],0);
             }
         }
     }];
}
@end
