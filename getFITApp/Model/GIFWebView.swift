//
//  GIFWebView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-20.
//

import SwiftUI
import WebKit

struct GIFWebView: UIViewRepresentable {
  let url: URL

  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    webView.scrollView.isScrollEnabled = false
    webView.contentMode = .scaleAspectFit
    return webView
  } // makeUIView()

  func updateUIView(_ webView: WKWebView, context: Context) {
    let htmlString = """
    <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
      </head>
      <body style="margin:0;padding:0;display:flex;justify-content:center;align-items:center;height:100%;">
        <img src="\(url.absoluteString)" style="max-width:auto;height:100%;" /> 
      </body>
    </html>
    """
    webView.loadHTMLString(htmlString, baseURL: nil)
  } // updateUIView()
} // GIFWebView

#Preview {
  GIFWebView(url: URL(string: "https://i.pinimg.com/originals/77/4f/12/774f127c279efe9e57bf53b18dd036b1.gif")!)
    .frame(width: 300, height: 300)
} // GIFWebView_Previews
