# LDDownloadError
记录用afn下载遇见的一个Bug
```      
主要是这个debug区的打印 浪费了很长时间 而没去直面代码的严谨性....
2017-08-25 10:20:32.369 AFN实现大文件断点下载[1145:35974] Error Domain=NSPOSIXErrorDomain Code=24 "Too many open files" UserInfo={NSErrorFailingURLKey=https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4267222417,1017407570&fm=200&gp=0.jpg, NSErrorFailingURLStringKey=https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4267222417,1017407570&fm=200&gp=0.jpg}
2017-08-25 10:20:32.369 AFN实现大文件断点下载[1145:35974] 第386个文件下载完成
2017-08-25 10:20:32.370 AFN实现大文件断点下载[1145:35974] Error Domain=NSPOSIXErrorDomain Code=24 "Too many open files" UserInfo={NSErrorFailingURLKey=https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4267222417,1017407570&fm=200&gp=0.jpg, NSErrorFailingURLStringKey=https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4267222417,1017407570&fm=200&gp=0.jpg}
.....
```      
