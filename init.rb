require 'redmine'
require 'auto_assignment_changer_hooks'

Redmine::Plugin.register :redmine_auto_assignment_changer do
  name 'AutoAssignmentChager'
  author 'Ryuma Tsukano'
  description 'ステータスの後ろに、「＠」（全角アットマーク）を付けて、ロール名を記載する。すると、チケット更新時に同ステータスに変更された場合、同ロール内のユーザがチケットの担当者として自動で変更される。'
  version '0.5'
  url 'http://www.ibs.inte.co.jp'
  author_url 'http://www.ibs.inte.co.jp'

#  menu :top_menu, :ibs1, { :controller => 'aohs', :action => 'index' }, :caption => "ワークフロー設定", :last => true

# permission :ibs1, {:aohs => [:index]}, :public => true
# permission :ibs1, {:auto_assignment => [:index]}, :public => true

 project_module :auto_assignment do
     permission :ibs1, :auto_assignment => :index
 end

 menu :project_menu, :ibs1, { :controller => 'auto_assignment', :action => 'index' }, :caption => 'ステータス承認者', :after => :activity, :param => :project_id

end
