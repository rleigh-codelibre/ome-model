/*
 * #%L
 * OME-XML C++ library for working with OME-XML metadata structures.
 * %%
 * Copyright © 2006 - 2016 Open Microscopy Environment:
 *   - Massachusetts Institute of Technology
 *   - National Institutes of Health
 *   - University of Dundee
 *   - Board of Regents of the University of Wisconsin-Madison
 *   - Glencoe Software, Inc.
 * %%
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * The views and conclusions contained in the software and documentation are
 * those of the authors and should not be interpreted as representing official
 * policies, either expressed or implied, of any organization.
 * #L%
 */

#include <map>
#include <memory>
#include <string>

#include <ome/xml/model/detail/OMEModel.h>
#include <ome/xml/model/Reference.h>

namespace ome
{
  namespace xml
  {
    namespace model
    {
      namespace detail
      {

        OMEModel::OMEModel ():
          ::ome::xml::model::OMEModel(),
          logger(ome::common::createLogger("OMEModel")),
          modelObjects(),
          references()
        {
        }

        OMEModel::~OMEModel ()
        {
        }

        std::shared_ptr<::ome::xml::model::OMEModelObject>
        OMEModel::addModelObject(const std::string&                                  id,
                                 std::shared_ptr<::ome::xml::model::OMEModelObject>& object)
        {
          // Don't store references.
          if (std::dynamic_pointer_cast<Reference>(object))
            return object;

          object_map_type::iterator i = modelObjects.find(id);
          if (i != modelObjects.end())
            i->second = object;
          else
            modelObjects.insert(std::make_pair(id, object));

          return object;
        }

        std::shared_ptr<::ome::xml::model::OMEModelObject>
        OMEModel::removeModelObject(const std::string& id)
        {
          std::shared_ptr<::ome::xml::model::OMEModelObject> ret;

          object_map_type::iterator i = modelObjects.find(id);
          if (i != modelObjects.end())
            {
              ret = i->second;
              modelObjects.erase(i);
            }

          return ret;
        }

        std::shared_ptr<::ome::xml::model::OMEModelObject>
        OMEModel::getModelObject(const std::string& id) const
        {
          std::shared_ptr<::ome::xml::model::OMEModelObject> ret;

          object_map_type::const_iterator i = modelObjects.find(id);
          if (i != modelObjects.end())
            ret = i->second;

          return ret;
        }

        const OMEModel::object_map_type&
        OMEModel::getModelObjects () const
        {
          return modelObjects;
        }

        bool
        OMEModel::addReference (std::shared_ptr<::ome::xml::model::OMEModelObject>& a,
                                std::shared_ptr<Reference>&                         b)
        {
          reference_map_type::iterator i = references.find(a);

          if (i == references.end())
            {
              std::pair<reference_map_type::iterator,bool> r =
                references.insert(std::make_pair(a, reference_map_type::value_type::second_type()));
              i = r.first;
            }
          i->second.push_back(b);
          return true;
        }

        const OMEModel::reference_map_type&
        OMEModel::getReferences () const
        {
          return references;
        }

        OMEModel::size_type
        OMEModel::resolveReferences ()
        {
          size_type unhandledReferences = 0;

          for (auto& i : references)
            {
              const std::shared_ptr<const ::ome::xml::model::OMEModelObject>& a(i.first);

              if (!a)
                {
                  const reference_list_type& references(i.second);

                  if (references.empty())
                    {
                      BOOST_LOG_SEV(logger, ome::logging::trivial::warning)
                        << "No references to null object; continuing";
                    }
                  else
                    {
                      BOOST_LOG_SEV(logger, ome::logging::trivial::warning)
                        << "Null reference to " << references.size()
                        << " objects; continuing";
                    }
                  unhandledReferences += references.size();
                }
              else
                {
                  reference_list_type& references(i.second);

                  for (auto& ref : references)
                    {
                      if (!ref)
                        {
                          BOOST_LOG_SEV(logger, ome::logging::trivial::warning)
                            << typeid(*a).name() << "@" << a
                            << " reference to null object; continuing";
                        }
                      else
                        {
                          const std::string& referenceID = ref->getID();

                          std::shared_ptr<::ome::xml::model::OMEModelObject> b = getModelObject(referenceID);
                          if (!b)
                            {
                              BOOST_LOG_SEV(logger, ome::logging::trivial::warning)
                                << typeid(*a).name() << "@" << a
                                << " reference to " << referenceID
                                << " missing from object hierarchy";
                              unhandledReferences++;
                            }
                          else
                            {
                              std::shared_ptr<::ome::xml::model::OMEModelObject> aw(std::const_pointer_cast<::ome::xml::model::OMEModelObject>(a));
                              aw->link(ref, b);
                            }
                        }
                    }
                }
            }
          return unhandledReferences;
        }

      }
    }
  }
}
