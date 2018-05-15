module Api
  module V1
    class XlsexporterController < ApplicationController
      def books
        @books = Book.all

        p = Axlsx::Package.new
        wb = p.workbook

        wb.add_worksheet(name: "Books") do |sheet|
          sheet.add_row Book.column_names
          @books.each do |book|
            sheet.add_row book.attributes.values
          end
        end

        send_data p.to_stream.read, :type => "application/xlsx", :filename => "books.xlsx"
      end
      def members
        @members = Member.all

        p = Axlsx::Package.new
        wb = p.workbook

        wb.add_worksheet(name: "Members") do |sheet|
          sheet.add_row ["id", "email", "book(s) created", "created_at", "updated_at"]
          @members.each do |member|
            sheet.add_row [member.id, member.email, member.books.count, member.created_at, member.updated_at]
          end
        end

        send_data p.to_stream.read, :type => "application/xlsx", :filename => "members.xlsx"
      end
    end
  end
end
