### Git 命令 

#### 分支 
-  查看分支 git branch
-  切换分支 git chekout master
-  创建本地分支 git branch fenzhi_name
-  将本地分支推到远端 git push origin /(提示)： git push --set-upstream origin fenzhi_name
-  将远端分支拉取到(本地不存在的分支)git checkout -b 本地分支名 origin/远程分支名
-  查看远程分支 git branch -r
-  创建分支并切换 git checkout -b fenzhi_name
-  删除分支 git branch -d fenzhi_name 
-  强制删除分支 git branch -D fenzhi_name 
-  删除远程分支 git push origin : fenzhi_name

#### 常用配置
- 设置用户名 git config --global user.name '用户名'
- 设置邮箱 git config --global user.email '邮箱'
- 查看所有配置 git config -l
- 设置别名 git config --global alias.st status

#### 暂存区
- git add <file>
- git add .

#### 工作区
- git commit <file>
- git commit .
- git commit - a
- 提交信息 git commit -am "提交信息
- 修改最后一次提交信息 git commit -amend 