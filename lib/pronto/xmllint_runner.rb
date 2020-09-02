require 'pronto'
require 'shellwords'

module Pronto
  class XMLLintRunner < Runner
    extend Forwardable

    EXTENSION = /^\..*xml$/

    def_delegator self, :checkable?

    def run
      return [] if !@patches || @patches.count.zero?

      @patches
        .select { |patch| patch.additions > 0 && checkable?(patch.new_file_full_path) }
        .reduce([]) { |results, patch| results.concat(inspect(patch)) }
    end

    class << self
      def checkable?(path)
        path_has_extension?(path)
      end

      def path_has_extension?(path)
        !(EXTENSION =~ path.extname).nil?
      end

    end

    private :checkable?
    private

      def repo_path
        @repo_path ||= @patches.first.repo.path
      end

      def inspect(patch)
        new_message('XMLLint failed.') if run_xmllint(patch).nonzero?
      end

      def new_message(offence)
        level = :error

        Message.new(nil, nil, level, offence, nil, self.class)
      end

      def run_xmllint(patch)
        Dir.chdir(repo_path) do
          escaped_file_path = Shellwords.escape(patch.new_file_full_path.to_s)
          `xmllint --nowarning --noout #{escaped_file_path}`
        end
        return $?.exitstatus
      end

  end
end
