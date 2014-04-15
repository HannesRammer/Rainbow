import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';
import 'package:xml/xml.dart';
import "inputbox.dart";
DivElement container = querySelector("#container");
ButtonElement fileReader = querySelector('#fileReader');
InputElement fileSelector = querySelector('#fileSelector');
Element inputDiv = querySelector('#input');
HtmlElement dartDiv = querySelector('#dart');
HtmlElement htmlDiv = querySelector('#html');
TextInputElement authorDiv = querySelector("#author"); 
TextInputElement themeNameDiv = querySelector("#themeName");
  
String defaultXmlString = 
'''<?xml version="1.0" encoding="utf-8"?>
<colorTheme id="24834" name="RAINBOW-HR" modified="2014-03-03 16:12:33" author="Hannes Rammer">
    <abstractMethod color="#BED6FF" />
    <annotation color="#53C6EB" />
    <background color="#272822" />
    <bracket color="#F9FAF4" />
    <builtin color="#FF007F" />
    <class color="#53C6EB" bold="true" />
    <commentTaskTag color="#CFBFAD" />
    <constant color="#A082BD" />
    <constructor color="#FF9451" />
    <currentLine color="#5B5A4E" />
    <deletionIndication color="#F90101" />
    <deprecatedMember color="#F90101" underline="true" />
    <directive color="#D05080" bold="true" />
    <dynamicType color="#CFBFAD" />
    <enum color="#E0E2E4" />
    <field color="#F2B50F" />
    <filteredSearchResultIndication color="#D8D8D8" />
    <findScope color="#FF00FF" />
    <foreground color="#FFFFFF" />
    <function color="#FF9451" />
    <getter color="#E8E2B7" />
    <importPrefix color="#CFBFAD" />
    <inheritedMethod color="#BED6FF" />
    <interface color="#C48CFF" />
    <javadoc color="#CFBFAD" />
    <javadocKeyword color="#D9E577" />
    <javadocLink color="#DDDDDD" />
    <javadocTag color="#EEEEEE" />
    <keyword color="#FF007F" />
    <keywordReturn color="#FF007F" />
    <lineNumber color="#999999" />
    <localVariable color="#00DD59" />
    <localVariableDeclaration color="#00DD59" />
    <method color="#FF7722" />
    <methodDeclaration color="#FF7722" bold="true" />
    <multiLineComment color="#CFBFAD" />
    <multiLineString color="#53C6EB" />
    <number color="#FF007F" />
    <occurrenceIndication color="#777777" />
    <operator color="#FFFFFF" />
    <parameterVariable color="#00DD59" underline="true" />
    <searchResultIndication color="#D8D8D8" />
    <selectionBackground color="#CC9900" />
    <selectionForeground color="#404040" />
    <setter color="#E8E2B7" />
    <singleLineComment color="#CFBFAD" />
    <sourceHoverBackground color="#FFFFFF" />
    <staticField color="#CFBFAD" />
    <staticFinalField color="#CFBFAD" />
    <staticMethod color="#FF7722" />
    <staticMethodDeclaration color="#FF7722" bold="true" />
    <string color="#53C6EB" />
    <typeArgument color="#BFA4A4" underline="true" />
    <typeParameter color="#BFA4A4" underline="true" />
    <writeOccurrenceIndication color="#00FF00" />
</colorTheme>
'''

/*'''<?xml version="1.0" encoding="utf-8"?>
<colorTheme id="24834" name="RAINBOW-HR" modified="2014-03-03 16:12:33" author="Hannes Rammer">
    <abstractMethod color="#BED6FF" />
    <annotation color="#53C6EB" />
    <background color="#272822" />
    <bracket color="#F9FAF4" />
    <builtin color="#FF007F" />
    <class color="#53C6EB" bold="true" />
    <commentTaskTag color="#CFBFAD" />
    <constant color="#A082BD" />
    <constructor color="#FF9451" />
    <currentLine color="#5B5A4E" />
    <deletionIndication color="#F90101" />
    <deprecatedMember color="#F90101" underline="true" />
    <directive color="#D05080" bold="true" />
    <dynamicType color="#CFBFAD" />
    <enum color="#E0E2E4" />
    <field color="#F2B50F" />
    <filteredSearchResultIndication color="#D8D8D8" />
    <findScope color="#FF00FF" />
    <foreground color="#FFFFFF" />
    <function color="#FF9451" />
    <getter color="#E8E2B7" />
    <importPrefix color="#CFBFAD" />
    <inheritedMethod color="#BED6FF" />
    <interface color="#C48CFF" />
    <javadoc color="#CFBFAD" />
    <javadocKeyword color="#D9E577" />
    <javadocLink color="#DDDDDD" />
    <javadocTag color="#EEEEEE" />
    <keyword color="#FF007F" />
    <keywordReturn color="#FF007F" />
    <lineNumber color="#999999" />
    <localVariable color="#00DD59" />
    <localVariableDeclaration color="#00DD59" />
    <method color="#FF7722" />
    <methodDeclaration color="#FF7722" bold="true" />
    <multiLineComment color="#CFBFAD" />
    <multiLineString color="#53C6EB" />
    <number color="#FF007F" />
    <occurrenceIndication color="#777777" />
    <operator color="#FFFFFF" />
    <parameterVariable color="#00DD59" underline="true" />
    <searchResultIndication color="#D8D8D8" />
    <selectionBackground color="#CC9900" />
    <selectionForeground color="#404040" />
    <setter color="#E8E2B7" />
    <singleLineComment color="#CFBFAD" />
    <sourceHoverBackground color="#FFFFFF" />
    <staticField color="#CFBFAD" />
    <staticFinalField color="#CFBFAD" />
    <staticMethod color="#FF7722" />
    <staticMethodDeclaration color="#FF7722" bold="true" />
    <string color="#53C6EB" />
    <typeArgument color="#BFA4A4" underline="true" />
    <typeParameter color="#BFA4A4" underline="true" />
    <writeOccurrenceIndication color="#00FF00" />
</colorTheme>'''*/;


void main() {
  initPolymer().run(() {
    querySelector("#toggleInactive").onClick.listen((_){
          toggleInactive();
        });
    querySelector("#saveButton").onClick.listen((_){
          download();
        });
    updateExportLink();
    loopAdaptWindowSize();
    inputDiv.style.overflowY = "scroll";
    inputDiv.style.overflowX = "none";
    fileSelector.onChange.listen((e){
      FileList files = fileSelector.files;
      File file = files.item(0);
      readFile();
              
      
    });
    loadInputBoxesFromXmlString(defaultXmlString);
    appendTitle(dartDiv.querySelectorAll("span"));
    appendTitle(htmlDiv.querySelectorAll("span"));
  });
}

loadInputBoxesFromXmlString(String xmlString){
  container.children.clear();
  XmlElement xml = XML.parse(xmlString);
  XmlElement theme = xml.query("colorTheme")[0];
  authorDiv.value = theme.attributes["author"];
  
  themeNameDiv.value = theme.attributes["name"];
  theme.children.forEach((XmlElement e){
    var inputBox = new Element.tag("input-box");
    inputBox.id = e.name;
    inputBox.name = e.name;
    inputBox.color = e.attributes["color"];
    inputBox.bold = e.attributes["bold"] == 'true';
    inputBox.italic = e.attributes["italic"] == 'true';
    inputBox.underline = e.attributes["underline"] == 'true';
    inputBox.strikethrough = e.attributes["strikethrough"] == 'true';
    if(e.name.toLowerCase().contains("background") || e.name == ("foreground")){
      inputBox.showOptions=false;
    }
    inputBox.onMouseOver.listen((_) => setCodeHighlight(e.name));
    inputBox.onMouseOut.listen((_) => removeCodeHighlight(e.name));
    if(querySelector(".${e.name}") != null){
      inputBox.active = true;
    }
    setColor(e.name, e.attributes["color"]);
    setClass(e.name,inputBox);
    appendAncorLink(e.name);
    container.append(inputBox);
  });
}

void setCodeHighlight(String attrName){
  if(attrName != "foreground" && attrName != "background"){
    List l = querySelectorAll(".$attrName");
    l.forEach((HtmlElement e){
      e.style.boxSizing="borderBox";
      e.style.border = "1px solid #ff0000";
    });
  }
}

void removeCodeHighlight(String attrName){
  List l = querySelectorAll(".$attrName");
  l.forEach((HtmlElement e){
    e.style.border = "";
  });
}

void setColor(String attrName,String color){
  List l = querySelectorAll(".$attrName");
  if(attrName == "occurrenceIndication" || attrName == "currentLine" || attrName.toLowerCase().contains("background")){
    l.forEach((HtmlElement e){
      e.style.backgroundColor = color;
    });
  }else{
    l.forEach((HtmlElement e){
      e.style.color = color;
    });
  }
}

void appendAncorLink(String attrName){
  if(attrName != "background" && attrName != "foreground"){
    List l = querySelectorAll(".$attrName");
    l.forEach((HtmlElement e){
      e.onClick.listen((e) => window.location.assign("#$attrName"));
    });
  }
}


void appendTitle(List<Element> list){
  list.forEach((element){
    element.title = element.className;
    element.style.cursor = "pointer";
    element.onClick.listen((e){
      blink(element.classes.first);
    });
  });
}

void activeElements(List<Element> list){
  list.forEach((element){
    element.title = element.className;
    element.style.cursor = "pointer";
    element.onClick.listen((e){
      blink(element.classes.first);
    });
  });
}

void blink(String id){
  addHighlight(id);
  
  var future = new Future.delayed(const Duration(milliseconds: 150));
  future.then((_){
    removeHighlight(id);
    var future = new Future.delayed(const Duration(milliseconds: 150));
    future.then((_){
      addHighlight(id);
      var future = new Future.delayed(const Duration(milliseconds: 150));
      future.then((_){
        removeHighlight(id);
        var future = new Future.delayed(const Duration(milliseconds: 150));
        future.then((_){
          addHighlight(id);
          var future = new Future.delayed(const Duration(milliseconds: 150));
          future.then((_){
            removeHighlight(id);
          });
        });
      });
    });
  });  
}

void addHighlight(String id){
  var element = querySelector("#${id}") as PolymerElement;
  if (element != null){
    element.highlight = true;
  }
}

void removeHighlight(String id){
  var element = querySelector("#${id}");
  if (element != null){
    element.highlight = false;
  }
}

void setClass(String attrName, item){
  List classes = ["bold","italic","underline","strikethrough"];
  List l = querySelectorAll(".$attrName");
  l.forEach((HtmlElement e){
    if(item.bold){
      e.classes.add("bold");
    }
    if(item.italic){
      e.classes.add("italic");
    }
    if(item.underline){
      e.classes.add("underline");
    }
    if(item.strikethrough){
      e.classes.add("strikethrough");
    }
  });
  
}

void toggleInactive(){
  List l = querySelectorAll("input-box");
  l.forEach((InputBox e){
    if(!e.active){
      e.hide = !e.hide;  
    }
  });
}


readFile(){
  FileList files = fileSelector.files;
  File file = files.item(0);
  FileReader reader = new FileReader();
  reader.onLoad.listen((fileEvent) {
    print("file read");
    print("file content is ${reader.result}");
    loadInputBoxesFromXmlString(reader.result);
  });
  reader.onError.listen((evt) => print("error ${reader.error.code}"));
  reader.readAsText(file);
  
  
  
}
List lines = new List();

download(){
  prepareDownloadLink();
  querySelector('#fileSaver').click();  
}

void prepareDownloadLink(){
  preloadXmlString();
  updateExportLink();
}

void preloadXmlString(){
  lines.clear();
  lines.add('<?xml version="1.0" encoding="utf-8"?>\n');
  lines.add('<colorTheme name="${themeNameDiv.value}" author="${authorDiv.value}">\n');
  querySelectorAll("input-box").forEach((InputBox element){
    
    var bool = "";
    var italic = "";
    var underline = "";
    var strikethrough = "";
        
    if(element.bold){
      bool = " bold='${element.bold}'";
    }
    if(element.italic){
      italic = " italic='${element.italic}'";
    }
    if(element.underline){
      underline = " underline='${element.underline}'";
    }
    if(element.strikethrough){
      strikethrough = " strikethrough='${element.strikethrough}'";
    }
    lines.add('<${element.name} color="${element.color}"${bool}${italic}${underline}${strikethrough} />\n');
  });
  lines.add("</colorTheme>");
  print(lines);
}

updateExportLink(){
  AnchorElement downloadLink = querySelector('#fileSaver') ;
  // Plain text type, 'native' line endings
  String fileName = themeNameDiv.value.replaceAll(" ","_");
  var blob = new Blob(lines, 'text/plain', 'native');
  downloadLink.download = "$fileName.xml";
  downloadLink.href = Url.createObjectUrlFromBlob(blob).toString();
}

loopAdaptWindowSize(){
  var future = new Future.delayed(const Duration(milliseconds: 500));
  future.then((_){
    adaptWindowSize();
    loopAdaptWindowSize();
  });
}

adaptWindowSize(){
  if(inputDiv.style.height != "${window.innerHeight * 0.9}px"){
    inputDiv.style.height = "${window.innerHeight * 0.9}px";
    print(inputDiv.style.height);
  }
}


