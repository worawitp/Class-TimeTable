# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101205192127) do

  create_table "comments", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "comment_number"
    t.text     "content"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "number"
    t.integer  "instructor_id"
    t.integer  "year"
    t.string   "semester"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version_number"
    t.integer  "org_id"
  end

  create_table "forums", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
  end

  create_table "instructors", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "rooms", :force => true do |t|
    t.string   "room_number"
    t.integer  "capacity"
    t.string   "building"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffs", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_courses", :force => true do |t|
    t.integer  "student_id"
    t.integer  "take_course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveychoices", :force => true do |t|
    t.integer  "survey_id"
    t.integer  "choice_number"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.integer  "topic_id"
    t.datetime "close_datetime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timeslots", :force => true do |t|
    t.integer  "course_id"
    t.string   "day"
    t.time     "starttime"
    t.time     "endtime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version_number"
  end

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.text     "content"
    t.integer  "forum_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "fname",                     :limit => 100
    t.string   "lname",                     :limit => 100
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
    t.string   "type"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "surveychoice_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
