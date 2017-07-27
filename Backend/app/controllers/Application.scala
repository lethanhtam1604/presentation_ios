package controllers

import java.io.File
import javax.inject.{Inject, Named, Singleton}

import akka.actor.ActorSystem
import akka.pattern.ask
import akka.util.Timeout

import scala.concurrent.Future
import scala.concurrent.duration._
import com.typesafe.jse.Engine
import play.api.{Logger, Play}
import play.api.mvc._
import play.api.libs.concurrent.Execution.Implicits.defaultContext
import play.twirl.api.Html
import play.api.libs.ws._
import play.api.routing._

import scala.concurrent.Await
import play.api.libs.json.Writes
import play.api.libs.json.Json

class Application @Inject() (actorSystem: ActorSystem,ws: WSClient) extends Controller{
  implicit val timeout = Timeout(5.seconds)

  def index(s:String) = Action { implicit request =>
    Ok(views.html.index(Html("")))
  }
  def index2 = Action { implicit request =>
    Ok(views.html.index(Html("")))
  }
  def indexDev2 = Action { implicit request =>
    Ok(views.html.indexDev(Html("")))
  }
  def indexDev(s:String) = Action { implicit request =>
    Ok(views.html.indexDev(Html("")))
  }
  def javascriptRoutes = Action { implicit request =>
    Ok(
        JavaScriptReverseRouter("jsRoutes")(
          routes.javascript.BaseApi.getNew
        )
    ).as("text/javascript")
  }  
}
