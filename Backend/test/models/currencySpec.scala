package controllers

import org.scalatest._
import org.scalatestplus.play._
import models.{CountryModel, CurrencyHistoryModel, CurrencyModel}

import scala.concurrent.Await
import scala.concurrent.duration.Duration
import java.text.SimpleDateFormat
import java.util.Calendar

import Matchers._
import java.sql.Date
import java.sql.Timestamp


/**
 * add your integration spec here.
 * An integration test will fire up a whole play application in a real (or headless) browser
 */
class currencyServiceSpec extends PlaySpec with CurrencyServiceTrait with CurrencyHistoryModel with CurrencyModel with CountryModel{
   override val CurrencyHistorys=new CurrencyHistorysClass("testmem")
   override val Currencys=new CurrencysClass("testmem")
   
   "CurrencyService#getHistoryByCurrencyId" should {
    "return list model with same CurrencyID" in {
      //initDummy()         
      val testgetHistoryByCurrencyId = Await.result(getHistoryByCurrencyId(1),Duration.Inf)
      var count=0;
      for (item <- testgetHistoryByCurrencyId) {
        if (item.CurrencyId==1)
        {
          count+=1
        }
      }
      count mustEqual testgetHistoryByCurrencyId.length
    }
   }
   
   "CurrencyService#getCurrencyList" should {
    "return all currency record" in {        
      val testGetCurrencyList = Await.result(getCurrencyList,Duration.Inf)
      testGetCurrencyList.length mustEqual 3
    }
   }
   
   "CurrencyService#addExchangeRate" should {
    "add end_date of last record and add new record with blank end_date and CurrencyID = currency_id" in { 
      val format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")  
      val c1 = Calendar.getInstance();
      c1.setTime(format.parse("2016-07-03 00:00:00"))
      val newItem = new models.CurrencyHistory(0,0,new Timestamp(c1.getTime.getTime),None,200,0,None,None)
      
      val testGetCurrencyList = Await.result(addExchangeRate(1,newItem),Duration.Inf)
      
      val getByCurrencyId = Await.result(getHistoryByCurrencyId(1),Duration.Inf)
      c1.setTime(newItem.StartDate)
      c1.add(Calendar.SECOND,-1)
      val lastRecordEndDate = new Timestamp(c1.getTime.getTime)
      
      getByCurrencyId.length should be >= 2
      getByCurrencyId(getByCurrencyId.length-2).EndDate mustEqual Option(lastRecordEndDate)
      getByCurrencyId(getByCurrencyId.length-1).EndDate mustEqual None
      getByCurrencyId(getByCurrencyId.length-1).CurrencyId mustEqual 1
      
    }
   }
   
   "CurrencyService#deleteLastExchangeRate" should {
    "delete last record and remove end date of next last record in Histories" in {    
      val testGetCurrencyList = Await.result(deleteExchangeRate(1,1),Duration.Inf)
      val getByCurrencyId = Await.result(getHistoryByCurrencyId(1),Duration.Inf)
      if (testGetCurrencyList.get.success==1){
        getByCurrencyId.length mustEqual 1
        getByCurrencyId.last.EndDate mustEqual None
      }else
      {
        getByCurrencyId.length mustEqual 2
      }

    }
   }
     
   
   "CurrencyService#changeName" should {
    "change name of currency" in {    
      val testChangeRate = Await.result(changeName(1,"newname"),Duration.Inf)
      val getCurrency = Await.result(Currencys.get(1),Duration.Inf)
      getCurrency.get.CurrencyName mustEqual "newname"
    }
   }
     
  
}
