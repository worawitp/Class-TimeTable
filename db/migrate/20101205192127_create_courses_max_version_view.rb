class CreateCoursesMaxVersionView < ActiveRecord::Migration
  def self.up
    create_view_sql = "create view courses_max_version as
       select c2.* from courses c2 join (
       select max(version_number), org_id from courses group by org_id) as c1 on
       c1.max=c2.version_number and c1.org_id=c2.org_id"
    execute(create_view_sql)

  end

  def self.down
    drop_view_sql = "drop view courses_max_version"
    execute(drop_view_sql)
  end
end
