# coding: utf-8
module Jekyll
  module Commands
    class Cooking < Command
      def self.init_with_program(prog)
        prog.command(:cooking) do |c|
          c.syntax "cooking NAME"
          c.description "Creates a new cooking with the given NAME"

          options.each { |opt| c.option *opt }

          c.action { |args, options| process args, options }
        end
      end

      def self.options
        [
          ["extension", "-x EXTENSION", "--extension EXTENSION", "Specify the file extension"],
          ["layout", "-l LAYOUT", "--layout LAYOUT", "Specify the cooking layout"],
          ["force", "-f", "--force", "Overwrite a cooking if it already exists"],
          ["date", "-d DATE", "--date DATE", "Specify the cooking date"],
          ["config", "--config CONFIG_FILE[,CONFIG_FILE2,...]", Array, "Custom configuration file"],
          ["source", "-s", "--source SOURCE", "Custom source directory"],
        ]
      end

      def self.extra_params(params)
        {
          "date" => params.date.strftime("%Y-%m-%d %T %z"),
          "original-date" => params.date.strftime("%Y-%m-%d"),
          "categories" => "cooking",
          "hidden" => true,
          "comments" => true,
          "thumbnail" => nil,
          "images" => nil
        }
      end

      def self.process(args = [], options = {})
        params = CookingArgParser.new args, options
        params.validate!

        cooking = CookingFileInfo.new(params, extra_params(params))

        Compose::FileCreator.new(cooking, params.force?, params.source).create!
      end

      class CookingArgParser < Compose::ArgParser
        def date
          options["date"].nil? ? Time.now : DateTime.parse(options["date"])
        end
      end

      class CookingFileInfo < Compose::FileInfo
        def resource_type
          'story'
        end

        def path
          "_posts/stories/#{file_name}"
        end

        def image_folder
          "assets/images/posts/cooking/#{_date_stamp}-#{name}"
        end

        def file_content
          content = "\n"
          content += "<!--separate--> \n\n"
          content += "<!--{% include image src=\"\" %}-->"
        end

        def file_name
          "#{_date_stamp}-#{super}"
        end

        def _date_stamp
          @params.date.strftime "%Y-%m-%d"
        end
      end
    end
  end
end
