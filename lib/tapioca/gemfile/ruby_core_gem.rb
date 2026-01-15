# typed: strict
# frozen_string_literal: true

module Tapioca
  class Gemfile
    # A synthetic gem specification that represents Ruby's core classes
    class RubyCoreGem
      extend T::Sig

      CORE_CLASSES = T.let([
        "Array",
        "BasicObject",
        "Binding",
        "Class",
        "Comparable",
        "Complex",
        "Data",
        "Dir",
        "Encoding",
        "Enumerable",
        "Enumerator",
        "Exception",
        "FalseClass",
        "Fiber",
        "File",
        "Float",
        "GC",
        "Hash",
        "Integer",
        "IO",
        "Kernel",
        "Marshal",
        "MatchData",
        "Method",
        "Module",
        "NilClass",
        "Numeric",
        "Object",
        "ObjectSpace",
        "Proc",
        "Process",
        "Random",
        "Range",
        "Rational",
        "Regexp",
        "Signal",
        "String",
        "Struct",
        "Symbol",
        "Thread",
        "ThreadGroup",
        "Time",
        "TracePoint",
        "TrueClass",
        "UnboundMethod",
        "Warning",
      ].freeze, T::Array[String])

      sig { returns(String) }
      attr_reader :name, :version, :full_gem_path

      sig { returns(T::Array[Pathname]) }
      attr_reader :files

      sig { void }
      def initialize
        @name = T.let("ruby-core", String)
        @version = T.let(RUBY_VERSION, String)
        @full_gem_path = T.let(RbConfig::CONFIG["rubylibdir"], String)
        @files = T.let([], T::Array[Pathname])
      end

      sig { returns(T::Array[T.untyped]) }
      def dependencies
        []
      end

      sig { returns(String) }
      def rbi_file_name
        "ruby-core@#{version}.rbi"
      end

      sig { params(path: String).returns(T::Boolean) }
      def contains_path?(path)
        # Core classes are defined in the Ruby VM, not in files
        false
      end

      sig { returns(T::Array[String]) }
      def exported_rbi_files
        []
      end

      sig { returns(T::Boolean) }
      def export_rbi_files?
        false
      end

      sig { params(gemfile_dir: String).returns(T::Boolean) }
      def ignore?(gemfile_dir)
        false
      end

      sig { params(other: BasicObject).returns(T::Boolean) }
      def ==(other)
        RubyCoreGem === other
      end

      sig { returns(T::Set[String]) }
      def core_symbols
        Set.new(CORE_CLASSES)
      end

      sig { void }
      def parse_yard_docs
        # Core classes don't have yard docs to parse
      end

      sig { params(file: Pathname).returns(Pathname) }
      def relative_path_for(file)
        file
      end
    end
  end
end
