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

#### 添加到暂存区
- git add <file>
- git add .

#### 工作区
- git commit <file>
- git commit .
- git commit - a
- 提交信息 git commit -am "提交信息
- 修改最后一次提交信息 git commit -amend 

#### 提交版本库
- git push 

#### 修改暂存区
git checkout <file>  
git checkout .  

####改变暂存区的修改（其实是重置HEAD，将指定版本库的内容状态去覆盖暂存区，从而达到暂存区的改变）
git reset <file>  #从暂存区恢复到工作区（不指定版本id，则默认为最后一次提交的版本id）
git reset .  #从暂存区恢复到工作区
git reset $id # 恢复到指定的提交版本，该$id之后的版本提交都恢复到工作区
git reset --hard $id #恢复到指定的提交版本，该$id之后的版本提交全部会被抛弃，将不出现在工作区

#####注：如果不小心使用了错误的HEAD重置，会发现HEAD指向了重置的版本id，该版本之后的版本提交都不见了，使用git log也无法找到，那么怎么恢复呢？使用下面两个命令
git reflog show master | head #会显示所有的版本记录
git reset --hard $id #重新重置，至于--hard，请根据你时候将改变的内容放到工作区还是直接抛弃进行选择

#------------------------------------------
#恢复某次提交（其实是某提提交的回滚操作，不影响其他的提交，所产生的效果创建一个新版本提交去回滚将指定的提交删除，包括产生的差异文件不会出现在工作区，而是直接被抛弃）
git revert <$id>
git revert HEAD
#####这里有一个很好的讲解revert与reset的差异：git reset 是把HEAD向后移动了一下，而git revert是HEAD继续前进，只是新的commit的内容和要revert的内容正好相反，能够抵消要被revert的内容。

####删除文件的几种方法（貌似Git2.0后有了变化）
#####第一种直接在工作区删除
rm your_file #直接在工作区删除文件
git add -u . #将有改动的都提交到暂存区（包括修改的，删除的等操作），貌似git2.0 不加 -u 参数也可以
git commint -m "message" #提交版本库

####第二种方法直接在工作区删除
rm your_file #直接在工作区删除文件
git commit -am "message" #这个在前面提过，直接可以提交版本库，-a会包括包括git add/ git rm /git commint 这三个操作

#####第三种方法使用git rm
git rm <file> #不仅在工作区将文件删除，同时将该删除操作提交到暂存区
git commint -m "message" #提交版本库

#####关于git rm的其他补充
git rm --cached <file> #从暂存区中除去该文件，git将不再跟踪该文件的变更，但仍然在工作区内，在需要.gitignore时经常用到
