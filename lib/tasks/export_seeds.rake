# ローカル環境のデータをseedファイルに書き込む為のTask
# 実行コマンド rake db:export:seeds
namespace :db do
  namespace :export do
    desc 'Export data to seeds.rb file'
    task seeds: :environment do
      require 'fileutils'

      # ファイルのパス
      seeds_file = 'db/seeds.rb'
      File.open(seeds_file, 'w') do |file|
        file.write("# db/seeds.rb\n\n")
      end

      write_delete_commands(seeds_file)
      write_user_data(seeds_file)
      write_tag_data(seeds_file)
      write_prompt_data(seeds_file)
      write_note_data(seeds_file)
      write_prompt_tag_data(seeds_file)
      write_note_tag_data(seeds_file)
      write_reference_data(seeds_file)

      puts "Data exported to #{seeds_file}"
    end
  end
end

private

def write_delete_commands(seeds_file)
  File.open(seeds_file, 'a') do |file|
    # 依存関係を考慮して各テーブルを削除
    file.write("PromptTag.delete_all\n")
    file.write("NoteTag.delete_all\n")
    file.write("Prompt.delete_all\n")
    file.write("Note.delete_all\n")
    file.write("Reference.delete_all\n")
    file.write("Tag.delete_all\n")
    file.write("User.delete_all\n")
  end
end

def write_user_data(seeds_file)
  File.open(seeds_file, 'a') do |file|
    file.write("# PWは登録した後で直接編集する必要あり\n")
    User.find_each do |user|
      nickname = user.nickname.gsub("'", "\\\\'")
      email = user.email.gsub("'", "\\\\'")
      file.write("User.create!(id: #{user.id}, nickname: '#{nickname}', email: '#{email}', " \
                 "password: 'xxxxxxxxx', group_id: #{user.group_id})\n")
    end
  end
end

def write_tag_data(seeds_file)
  File.open(seeds_file, 'a') do |file|
    Tag.find_each do |tag|
      tag_name = tag.tag_name.gsub("'", "\\\\'")
      file.write("Tag.create!(id: #{tag.id}, tag_name: '#{tag_name}', color_code: #{tag.color_code})\n")
    end
  end
end

def write_prompt_data(seeds_file)
  File.open(seeds_file, 'a') do |file|
    Prompt.includes(:user).find_each do |prompt|
      title = prompt.title.gsub("'", "\\\\'")
      content = prompt.content.gsub("'", "\\\\'")
      file.write("Prompt.create!(id: #{prompt.id}, user: User.find(#{prompt.user_id}), title: '#{title}', " \
                 "content: '#{content}', category_id: #{prompt.category_id}, is_public: #{prompt.is_public}, " \
                 "group_id: #{prompt.group_id})\n")
    end
  end
end

def write_note_data(seeds_file)
  File.open(seeds_file, 'a') do |file|
    Note.includes(:user).find_each do |note|
      title = note.title.gsub("'", "\\\\'")
      content = note.content.gsub("'", "\\\\'")
      prompt_id = note.prompt_id ? "Prompt.find(#{note.prompt_id})" : 'nil'
      file.write("Note.create!(id: #{note.id}, user: User.find(#{note.user_id}), title: '#{title}', " \
                 "content: '#{content}', category_id: #{note.category_id}, is_public: #{note.is_public}, " \
                 "group_id: #{note.group_id}, prompt_id: #{prompt_id})\n")
    end
  end
end

def write_prompt_tag_data(seeds_file)
  File.open(seeds_file, 'a') do |file|
    PromptTag.find_each do |prompt_tag|
      file.write("PromptTag.create!(id: #{prompt_tag.id}, prompt: Prompt.find(#{prompt_tag.prompt_id}), " \
                 "tag: Tag.find(#{prompt_tag.tag_id}))\n")
    end
  end
end

def write_note_tag_data(seeds_file)
  File.open(seeds_file, 'a') do |file|
    NoteTag.find_each do |note_tag|
      file.write("NoteTag.create!(id: #{note_tag.id}, note: Note.find(#{note_tag.note_id}), " \
                 "tag: Tag.find(#{note_tag.tag_id}))\n")
    end
  end
end

def write_reference_data(seeds_file)
  File.open(seeds_file, 'a') do |file|
    Reference.find_each do |reference|
      referencable = "#{reference.referencable_type}.find(#{reference.referencable_id})"
      file.write("Reference.create!(id: #{reference.id}, referencable: #{referencable}, click_count: #{reference.click_count})\n")
    end
  end
end
