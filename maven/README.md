# How to install Maven on Windows 10
In order to install maven on a Windows machine you will need to install JDK first as Maven is a Java based tool. If you are installing Maven 3.3 then you required JDK version 1.7 or above.
## Steps to install Maven on Windows 10
**1.Set JAVA_HOME path**  
**2.Download Maven Zip**  
**3.Setup environment variable for Maven (M2_HOME)**  
**4.Verify installation**  

1) Setup JAVA_HOME
Please make sure you have set the JAVA_HOME path after installation of the JDK. You may refer my previous article to setup JAVA_HOME path in Windows machine.

2) Download Maven Zip
Download maven zip file from the official website and extract it to the directory you wish to install. And configure the environment variable. I have downloaded apache-maven-3.5.0-bin.zip under C:\Program Files\Maven for demonstration purpose.
![image](https://user-images.githubusercontent.com/1461161/231361455-85fd2104-69b2-4ae1-b574-bcffb919c1ff.png)

3) Add new environment variables for Maven (M2_HOME) and append it to the PATH variable
Add M2_HOME variables in the Windows environment variable, and point it to your Maven folder.
![image](https://user-images.githubusercontent.com/1461161/231361482-5a458b63-5326-402b-a76b-ab6237e2df7e.png)

Update PATH variable and append maven bin folder %M2_HOME%\bin to PATH variable
![image](https://user-images.githubusercontent.com/1461161/231361551-7d654f47-0ebb-4094-b5ca-cd9cb2b72061.png)

4) Verify Installation
Go to windows command line and verify maven setup.
mvn -version


![image](https://user-images.githubusercontent.com/1461161/231361570-de6f2a75-7773-4910-aff6-db4c01798f4d.png)
