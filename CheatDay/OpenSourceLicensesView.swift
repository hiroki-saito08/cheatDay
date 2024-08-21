import SwiftUI

struct OpenSourceLicensesView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("オープンソースライセンス")
                    .font(.yomogiTitle()) // Applying custom font for the title
                    .padding(.bottom, 8)
                
                // Example of including a license for a library
                LicenseSection(
                    libraryName: "Alamofire",
                    license: """
                    MIT License

                    Copyright (c) 2014-2023 Alamofire Software Foundation (http://alamofire.org/)

                    Permission is hereby granted, free of charge, to any person obtaining a copy
                    of this software and associated documentation files (the "Software"), to deal
                    in the Software without restriction, including without limitation the rights
                    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
                    copies of the Software, and to permit persons to whom the Software is
                    furnished to do so, subject to the following conditions:

                    The above copyright notice and this permission notice shall be included in
                    all copies or substantial portions of the Software.

                    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
                    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
                    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
                    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
                    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
                    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
                    THE SOFTWARE.
                    """
                )
                
                // Add more licenses as needed for each library you use
                // Example:
                // LicenseSection(
                //     libraryName: "LibraryName",
                //     license: "Full license text for the library."
                // )
                
            }
            .padding()
        }
        .navigationBarTitle("オープンソースライセンス", displayMode: .inline)
    }
}

struct LicenseSection: View {
    let libraryName: String
    let license: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(libraryName)
                .font(.yomogiHeadline()) // Applying custom font for the library name
                .padding(.bottom, 4)
            Text(license)
                .font(.yomogiBody()) // Applying custom font for the license text
                .foregroundColor(.secondary)
        }
    }
}
