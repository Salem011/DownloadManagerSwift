# DownloadManagerSwift

DownloadManagerSwift is a Swift framework to download and cache files.
It uses NSCache to cache the downloaded files as NSData objects.

How it works:
- First you create a wrapper class to convert the cached NSData object to your file type.
- You pass the url string with the wrapper class which conforms to the protocol DownloadedFileWrapper.
- DownloadManagerSWift is currently supporting UIImage and JSON files by having the ImageWrapper and JsonWrapper inside it.
- DownloadManagerSwift looks for cached files at first and if found, it will be passed to your completion block
- If the file is not found, then the frameworks downloads the file first and then cache it.

Setup:
- Add DownloadManagerSwift.framework to "Embedded Binaries" section at Xcode > Your Project Target > General Tab
- Inside your class, import DownloadManagerSwift

Example:
- Simply, just pass the url and the wrapper file.

  let imageUrl = "https://www.gettyimages.com/gi-resources/images/Embed/new/embed2.jpg"
   DownloadManager.loadFile(fromUrl: imageUrl, fileWrapper: imageWrapper) { (file, error) in
       let image = file as! UIImage
       // Use the downloaded image
   }


Please have a look at DownloadManagerSwiftExample project for more usage examples.
