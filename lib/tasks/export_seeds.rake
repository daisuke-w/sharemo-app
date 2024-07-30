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

        # User
        file.write("User.delete_all\n")
        User.find_each do |user|
          file.write("User.create!(nickname: '#{user.nickname}', email: '#{user.email}', encrypted_password: '#{user.encrypted_password}', group_id: #{user.group_id})\n")
        end

        # Tag
        file.write("Tag.delete_all\n")
        Tag.find_each do |tag|
          file.write("Tag.create!(tag_name: '#{tag.tag_name}', color_code: #{tag.color_code})\n")
        end

        # Note
        file.write("Note.delete_all\n")
        Note.includes(:user).find_each do |note|
          file.write("Note.create!(user: User.find(#{note.user_id}), title: '#{note.title}', content: '#{note.content}', category_id: #{note.category_id}, is_public: #{note.is_public}, group_id: #{note.group_id})\n")
        end

        # Prompt
        file.write("Prompt.delete_all\n")
        Prompt.includes(:user).find_each do |prompt|
          file.write("Prompt.create!(user: User.find(#{prompt.user_id}), title: '#{prompt.title}', content: '#{prompt.content}', category_id: #{prompt.category_id}, is_public: #{prompt.is_public}, group_id: #{prompt.group_id})\n")
        end

        # NoteTag
        file.write("NoteTag.delete_all\n")
        NoteTag.find_each do |note_tag|
          file.write("NoteTag.create!(note: Note.find(#{note_tag.note_id}), tag: Tag.find(#{note_tag.tag_id}))\n")
        end

        # PromptTag
        file.write("PromptTag.delete_all\n")
        PromptTag.find_each do |prompt_tag|
          file.write("PromptTag.create!(prompt: Prompt.find(#{prompt_tag.prompt_id}), tag: Tag.find(#{prompt_tag.tag_id}))\n")
        end

        # Reference
        file.write("Reference.delete_all\n")
        Reference.find_each do |reference|
          file.write("Reference.create!(referencable: #{reference.referencable_type}.find(#{reference.referencable_id}), click_count: #{reference.click_count})\n")
        end
      end

      puts "Data exported to #{seeds_file}"
    end
  end
end
