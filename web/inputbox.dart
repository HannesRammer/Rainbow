import 'package:polymer/polymer.dart';
import 'dart:html';

/**
 * A Polymer click counter element.
 */
@CustomTag('input-box')
class InputBox extends PolymerElement {
  @published String id = "default";
  @published String name = "default";
  @published String color = "#ff0000";
  @published bool highlight = false;  
  @published bool active = false;
  @published bool hide = true;
      
  @published bool showOptions = true;//<b>
  
  @published bool bold = false;//<b>
  @published bool italic = false;//<i>
  @published bool underline = false;//<u>
  @published bool strikethrough = false;//<s>
  
  InputBox.created() : super.created() {
    
  }
  
  /*
  font-style: italic;
  font-weight: bold;
  text-decoration: line-through;
  text-decoration: underline;
  */
  void toggleClass(className){
    List l = querySelectorAll(".$name");
    l.forEach((HtmlElement e){
      e.classes.toggle(className);
    });
  }
  
  void setColor(){
    List l = querySelectorAll(".$name");
    if(name == "occurrenceIndication" || name == "currentLine" || name.toLowerCase().contains("background")){
      l.forEach((HtmlElement e){
        e.style.backgroundColor = color;
      });
    }else{
      l.forEach((HtmlElement e){
        e.style.color = color;
      });
    }
  }

  void toggleBold(){
    this.bold = !this.bold; 
    toggleClass("bold");     
  }

  void toggleItalic(){
    this.italic = !this.italic; 
    toggleClass("italic");     
  }
     
  void toggleStrikethrough(){
    this.underline = false;
    List l = querySelectorAll("span.$name");
    l.forEach((HtmlElement e){
      e.classes.remove("underline");
    });
    this.strikethrough = !this.strikethrough; 
    toggleClass("strikethrough");
  }
    
  void toggleUnderline(){
    this.strikethrough= false;
    List l = querySelectorAll("span.$name");
    l.forEach((HtmlElement e){
      e.classes.remove("strikethrough");
    });
    this.underline = !this.underline;
    toggleClass("underline");
  }
}

