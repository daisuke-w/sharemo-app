# ローカル環境のデータをseedファイルに書き込む為のTask
namespace :db do
  namespace :export do
    desc 'Export data to seeds.rb file'
    task seeds: :environment do
      require 'fileutils'

      # ファイルのパス
      seeds_file = 'db/seeds.rb'
      File.open(seeds_file, 'w') do |file|
        file.write("# db/seeds.rb\n\n")

        # 依存関係を考慮して各テーブルを削除
        file.write("PromptTag.delete_all\n")
        file.write("NoteTag.delete_all\n")
        file.write("Prompt.delete_all\n")
        file.write("Note.delete_all\n")
        file.write("Reference.delete_all\n")
        file.write("Tag.delete_all\n")
        file.write("User.delete_all\n")

        # User
        # PWは登録した後で直接編集する必要あり
        file.write("# PWは登録した後で直接編集する必要あり\n")
        User.find_each do |user|
          nickname = user.nickname.gsub("'", "\\\\'")
          email = user.email.gsub("'", "\\\\'")
          encrypted_password = user.encrypted_password.gsub("'", "\\\\'")
          file.write("User.create!(id: #{user.id}, nickname: '#{nickname}', email: '#{email}', password: 'xxxxxxxxx', group_id: #{user.group_id})\n")
        end

        # Tag
        Tag.find_each do |tag|
          tag_name = tag.tag_name.gsub("'", "\\\\'")
          file.write("Tag.create!(id: #{tag.id}, tag_name: '#{tag_name}', color_code: #{tag.color_code})\n")
        end

        # Prompt
        Prompt.includes(:user).find_each do |prompt|
          title = prompt.title.gsub("'", "\\\\'")
          content = prompt.content.gsub("'", "\\\\'")
          file.write("Prompt.create!(id: #{prompt.id}, user: User.find(#{prompt.user_id}), title: '#{title}', content: '#{content}', category_id: #{prompt.category_id}, is_public: #{prompt.is_public}, group_id: #{prompt.group_id})\n")
        end

        # Note
        Note.includes(:user).find_each do |note|
          title = note.title.gsub("'", "\\\\'")
          content = note.content.gsub("'", "\\\\'")
          file.write("Note.create!(id: #{note.id}, user: User.find(#{note.user_id}), title: '#{title}', content: '#{content}', category_id: #{note.category_id}, is_public: #{note.is_public}, group_id: #{note.group_id})\n")
        end

        # PromptTag
        PromptTag.find_each do |prompt_tag|
          file.write("PromptTag.create!(id: #{prompt_tag.id}, prompt: Prompt.find(#{prompt_tag.prompt_id}), tag: Tag.find(#{prompt_tag.tag_id}))\n")
        end

        # NoteTag
        NoteTag.find_each do |note_tag|
          file.write("NoteTag.create!(id: #{note_tag.id}, note: Note.find(#{note_tag.note_id}), tag: Tag.find(#{note_tag.tag_id}))\n")
        end

        # Reference
        Reference.find_each do |reference|
          referencable = "#{reference.referencable_type}.find(#{reference.referencable_id})"
          file.write("Reference.create!(id: #{reference.id}, referencable: #{referencable}, click_count: #{reference.click_count})\n")
        end
      end

      puts "Data exported to #{seeds_file}"
    end
  end
end
