import Foundation
extension DesignCodeApp {

    struct SectionInfo {
        var title: String
        var caption: String
        var body: String
        var image: String
    }

    struct TestmonialInfo {
        var text: String
        var name: String
        var job: String
        var avatar: String
    }
}

protocol DesignCodeAppHomePageDataSourceInterface {
    var sections: [DesignCodeApp.SectionInfo] { get }
    var testimonials: [DesignCodeApp.TestmonialInfo] { get }
}


